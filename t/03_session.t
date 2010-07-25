use strict;
use warnings;
use Plack::Test;
use Plack::Util;
use Test::More;
use Test::WWW::Mechanize::PSGI;
use t::Util;

my $app = Plack::Util::load_psgi 'NoPaste.psgi';

my $mech = Test::WWW::Mechanize::PSGI->new(app => $app);
$mech->get_ok('/counter');
my ($sid1, $cnt1) = split /:/, $mech->content;
is $cnt1, 1;
$mech->get_ok('/counter');
my ($sid2, $cnt2) = split /:/, $mech->content;
is $sid1, $sid2;
is $cnt2, 2;
$mech->get_ok('/counter');
my ($sid3, $cnt3) = split /:/, $mech->content;
is $sid1, $sid3;
is $cnt3, 3;

done_testing;

