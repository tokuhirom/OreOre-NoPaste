use strict;
use warnings;
use Plack::Test;
use Plack::Util;
use Test::More;
use Test::Requires 'Test::WWW::Mechanize::PSGI';

my $app = Plack::Util::load_psgi 'NoPaste.psgi';
if ($ENV{DEBUG}) {
    require Plack::Middleware::AccessLog;
    $app = Plack::Middleware::AccessLog->wrap($app);
}

my $mech = Test::WWW::Mechanize::PSGI->new(app => $app);
$mech->get_ok('/');
$mech->page_links_ok();
$mech->submit_form_ok({form_number => 1, fields => {body => "test"}});
$mech->base_like(qr{/entry/.+});

done_testing;
