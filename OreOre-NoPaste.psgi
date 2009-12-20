use strict;
use OreOre::NoPaste;
use OreOre::NoPaste::Web;
use File::Basename;
use DBI;

my $dir = dirname(__FILE__);
my $dsn = ["dbi:SQLite:dbname=$dir/data.sqlite", '', ''];
my $dbh = DBI->connect(@$dsn);
my $sql = slurp("$dir/sql/nopaste.sql");
$dbh->do($sql);

OreOre::NoPaste::Web->app("$dir/", {
    'M::DB' => {
        dsn => $dsn
    }
});

sub slurp {
    my $fname = shift;
    open my $fh, '<', $fname or die "$fname: $!";
    my $content = do { local $/; <$fh> };
    close $fh;
    $content;
}
