use strict;
use warnings;
use DBI;
use File::Slurp;
use File::Basename;
my $dir = dirname(__FILE__);
my $connect_info = ["dbi:SQLite:dbname=$dir/../data/data.sqlite", '', ''];
my $dbh = DBI->connect(@$connect_info);
my $sql = slurp("$dir/../sql/sqlite.sql");
$dbh->do($sql);

sub slurp {
    my $fname = shift;
    open my $fh, '<', $fname or die "$fname: $!";
    my $content = do { local $/; <$fh> };
    close $fh;
    $content;
}

+{
    'M::DB' => {
        connect_info => $connect_info
    }
}
