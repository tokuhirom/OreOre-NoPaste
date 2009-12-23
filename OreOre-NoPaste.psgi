use strict;
use OreOre::NoPaste;
use OreOre::NoPaste::Web;
use File::Basename;
use DBI;

my $dir = dirname(__FILE__);
my $connect_info = ["dbi:SQLite:dbname=$dir/data.sqlite", '', ''];
my $dbh = DBI->connect(@$connect_info);
my $sql = slurp("$dir/sql/nopaste.sql");
$dbh->do($sql);

OreOre::NoPaste::Web->app({
    'M::DB' => {
        connect_info => $connect_info
    }
});

sub slurp {
    my $fname = shift;
    open my $fh, '<', $fname or die "$fname: $!";
    my $content = do { local $/; <$fh> };
    close $fh;
    $content;
}
