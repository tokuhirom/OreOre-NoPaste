package t::Utils;
use strict;
use warnings;
use OreOre::NoPaste::Web;

sub make_app {
    my $sql = slurp("sql/sqlite.sql");

    my $dbh = DBI->connect("dbi:SQLite:", '', '') or die;
    $dbh->do($sql);

    my $app = OreOre::NoPaste::Web->to_app(config => {
        'M::DB' => {
            dbh => $dbh,
        },
    });
    return $app;
}

sub slurp {
    my $fname = shift;
    open my $fh, '<', $fname or die "$fname: $!";
    my $content = do { local $/; <$fh> };
    close $fh;
    $content;
}

1;
