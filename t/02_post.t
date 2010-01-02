use strict;
use warnings;
use Plack::Test;
use Plack::Util;
use Test::More;
use HTTP::Request::Common;
use DBI;
use t::Utils;

my $app = t::Utils::make_app();
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


