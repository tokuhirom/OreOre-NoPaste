package NoPaste::Web::Response;
use strict;
use warnings;
use parent qw/Plack::Response/;

sub not_found {
    my ($self) = @_;
    $self->status(404);
    $self->body('not found');
    $self;
}

1;
