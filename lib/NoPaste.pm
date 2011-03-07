package NoPaste;
use strict;
use warnings;
use parent qw/Amon2/;
use 5.010001;
our $VERSION='0.02';

use Amon2::Config::Simple;
sub load_config { Amon2::Config::Simple->load(shift) }

use Amon2::DBI;
sub dbh {
    my ($c) = @_;
    $c->{dbh} //= do {
        my $conf = $c->config->{'DBI'} || die "missing configuration for DBI";
        Amon2::DBI->connect(@$conf);
    };
}

1;
