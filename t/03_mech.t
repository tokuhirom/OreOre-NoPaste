use strict;
use warnings;
use Test::Requires 'Test::WWW::Mechanize::PSGI';
use Plack::Test;
use Plack::Util;
use OreOre::NoPaste::Web;
use Test::More;
use HTTP::Request::Common;
use DBI;
use Test::WWW::Mechanize::PSGI;

use t::Utils;

my $app = t::Utils::make_app();

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

