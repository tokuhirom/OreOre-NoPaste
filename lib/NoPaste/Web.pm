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
            version => sub { @_ == 1 ? $_[0]->VERSION : NoPaste->VERSION }, 
        },
    }
);

use Tiffany::Text::Xslate;
my $view = Tiffany::Text::Xslate->new(__PACKAGE__->config->{'Text::Xslate'});
sub create_view { $view }

use NoPaste::Web::Dispatcher;
sub dispatch { NoPaste::Web::Dispatcher->dispatch(@_) }

__PACKAGE__->load_plugins('Web::FillInFormLite');
__PACKAGE__->load_plugins('Web::NoCache');

sub show_error {
    my ($c, $message) = @_;
    $c->render('show_error.tt', {message => $message});
}

1;
