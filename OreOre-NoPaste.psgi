use strict;
use OreOre::NoPaste::Web;

my $app = OreOre::NoPaste::Web->app();
if ($ENV{OREORE_NOPASTE_CONFIG_NAME} eq 'development') {
    require Plack::Middleware::Debug;
    $app = Plack::Middleware::Debug->wrap($app);
}
$app;
