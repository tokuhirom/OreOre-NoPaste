package NoPaste;
use strict;
use warnings;
use parent qw/Amon2/;
our $VERSION='0.02';

__PACKAGE__->load_plugins(qw/ConfigLoader LogDispatch/);
use NoPaste::DB;

sub db {
    my ($c) = @_;
    $c->{db} ||= do {
        my $conf = $c->config->{'DBIx::Skinny'} || die "missing configuration for DBIx::Skinny";
        NoPaste::DB->new($conf);
    };
}

1;
