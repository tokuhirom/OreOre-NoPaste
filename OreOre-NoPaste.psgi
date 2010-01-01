use strict;
use warnings;
use OreOre::NoPaste;
use OreOre::NoPaste::Web;
use Plack::Builder;
use File::Slurp qw/slurp/;

my $config = do 'config.pl' or die "Cannot load configuration file: $@";

# init
{
    my $c = OreOre::NoPaste->new(config => $config);
    my $sql =slurp("sql/sqlite.sql");
    $c->model('DB')->dbh->do($sql) or die "Cannot install schema";
}

builder {
    enable "Plack::Middleware::Static",
            path => qr{^/static/}, root => 'htdocs/';
    OreOre::NoPaste::Web->to_app(config => $config);
};
