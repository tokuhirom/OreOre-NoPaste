use strict;
use warnings;
use OreOre::NoPaste;
use OreOre::NoPaste::Web;
use Plack::Builder;
use File::Slurp qw/slurp/;
use DBI;

# init
my $dbh = DBI->connect( "dbi:SQLite:dbname=data/data.sqlite",
    '', '', { sqlite_unicode => 1 } ) or die $DBI::errstr;
my $sql = slurp("sql/sqlite.sql");
$dbh->do($sql) or die "Cannot install schema";

my $config = {
    'DB' => {
        dbh => $dbh,
    },
    'V::MT' => { cache_mode => 2, },
};

builder {
    enable "Plack::Middleware::Static",
            path => qr{^/static/}, root => 'htdocs/';
    OreOre::NoPaste::Web->to_app(config => $config);
};
