use strict;
use warnings;
use Test::Requires 'Test::WWW::Mechanize::PSGI';
use Plack::Test;
use Plack::Util;
use OreOre::NoPaste::Web;
use Test::More;
use HTTP::Request::Common;
use Plack::Middleware::StackTrace;
use File::Temp;
use DBI;
use Test::WWW::Mechanize::PSGI;


my $tmp = File::Temp->new(UNLINK => 1);
init($tmp);

my $app = OreOre::NoPaste::Web->app();
no warnings 'once';
no warnings 'redefine';
local *OreOre::NoPaste::config = sub {{
    'M::DB' => {
        connect_info => ["dbi:SQLite:dbname=$tmp", '', '']
    },
}};
my $mech = Test::WWW::Mechanize::PSGI->new(
    app => $app
);
$mech->get_ok('/');
$mech->followable_links();
$mech->submit_form(
    form_number => 1,
    fields => {
        body => 'yay'
    }
);
is $mech->status(), 302;
$mech->get_ok($mech->res->header('Location'));
$mech->content_contains('yay');

done_testing;

sub init {
    my $db = shift;
    my $sql = slurp("sql/sqlite.sql");
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

