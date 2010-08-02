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

sub redirect {
    my ( $self, $location ) = @_;
    my $url = do {
        if ( $location =~ m{^https?://} ) {
            $location;
        }
        else {
            my $url = NoPaste->context->request->base;
            $url      =~ s!/+$!!;
            $location =~ s!^/+([^/])!/$1!;
            $url .= $location;
        }
    };
    $self->SUPER::redirect($url);
}

1;
