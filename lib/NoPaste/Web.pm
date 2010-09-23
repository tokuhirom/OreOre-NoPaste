package NoPaste::Web;
use strict;
use warnings;
use parent qw/NoPaste Amon2::Web/;
__PACKAGE__->add_config(
    'Text::Xslate' => {
        'syntax'   => 'TTerse',
        'module'   => [ 'Text::Xslate::Bridge::TT2Like' ],
        'function' => {
            c => sub { Amon2->context() },
            uri_with => sub { Amon2->context()->req->uri_with(@_) },
            uri_for  => sub { Amon2->context()->uri_for(@_) },
        },
    }
);
__PACKAGE__->setup(
    view_class => 'Text::Xslate',
);
__PACKAGE__->load_plugins('Web::FillInFormLite');
__PACKAGE__->load_plugins('Web::NoCache');

sub show_error {
    my ($c, $message) = @_;
    $c->render('show_error.tt', {message => $message});
}

1;
