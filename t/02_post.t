use strict;
use warnings;
use Plack::Test;
use Plack::Util;
use OreOre::NoPaste::Web;
use Test::More;
use HTTP::Request::Common;
use Plack::Middleware::StackTrace;
use File::Temp;
use DBI;

my $tmp = File::Temp->new(UNLINK => 1);
init($tmp);

my $app = OreOre::NoPaste::Web->app();
no warnings 'once';
local *OreOre::NoPaste::config = sub {{
    'M::DB' => {
        connect_info => ["dbi:SQLite:dbname=$tmp", '', '']
    },
}};
test_psgi
    app => $app,
    client => sub {
        my $cb = shift;

        # post
        my $loc = do {
            my $req = POST 'http://localhost/post' => [
                body => 'hello, YAY'
            ];
            my $res = $cb->($req);
            is $res->code, 302;
            diag $res->content if $res->code == 500;
            $res->header("Location");
        };

        do {
            my $req = GET $loc;
            my $res = $cb->($req);
            is $res->code, 200;
            like $res->content, qr{hello, YAY};
            diag $res->content if $res->code == 500;
        };
    };

done_testing;

sub init {
    my $db = shift;
    my $sql = slurp("sql/nopaste.sql");
    my $dbh = DBI->connect("dbi:SQLite:dbname=$db", '', '');
    $dbh->do($sql);
}

sub slurp {
    my $fname = shift;
    open my $fh, '<', $fname or die "$fname: $!";
    my $content = do { local $/; <$fh> };
    close $fh;
    $content;
}

