package NoPaste;
use strict;
use warnings;
use parent qw/Amon2/;
our $VERSION='0.02';

use NoPaste::DB;

use Amon2::Config::Simple;
sub load_config { Amon2::Config::Simple->load(shift) }

sub db {
    my ($c) = @_;
    $c->{db} ||= do {
        my $conf = $c->config->{'DBIx::Skinny'} || die "missing configuration for DBIx::Skinny";
        NoPaste::DB->new($conf);
    };
}

1;
