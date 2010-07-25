package NoPaste::Web;
use Mouse;
use NoPaste;
use NoPaste::ConfigLoader;
use Text::Xslate 0.1047;
use Plack::Request;
use NoPaste::Web::Response;
use Module::Find qw/useall/;
use Encode;
use Log::Dispatch;
use NoPaste::Web::C;
use File::Spec;

extends 'NoPaste';

our $VERSION = '0.01';

has 'log' => (
    is      => 'ro',
    isa     => 'Log::Dispatch',
    lazy    => 1,
    default => sub {
        my $self = shift;
        Log::Dispatch->new( %{ $self->config->{'Log::Dispatch'} || {} } );
    },
);

has config => (
    is       => 'ro',
    isa      => 'HashRef',
    required => 1,
);

has env => (
    is => 'ro',
    isa => 'HashRef',
    required => 1,
);

has req => (
    is      => 'ro',
    isa     => 'Plack::Request',
    lazy    => 1,
    default => sub {
        my $self = shift;
        Plack::Request->new( $self->env );
    }
);

has args => (
    is       => 'rw',
    isa      => 'ArrayRef',
);

has res => (
    is      => 'ro',
    isa     => 'Plack::Response',
    default => sub {
        NoPaste::Web::Response->new;
    },
);

sub request  { shift->req(@_) }
sub response { shift->res(@_) }

sub to_app {
    my ($class) = @_;

    my $config = NoPaste::ConfigLoader->load;
    sub {
        my $env = shift;
        my $c = $class->new(env => $env, config => $config);
        no warnings 'redefine';
        local *NoPaste::context = sub { $c };
        if (my $m = NoPaste::Web::C->router->match($env)) {
            $m->{code}->($c, $m);
            return $c->res->finalize;
        } else {
            my $content = 'not found';
            return [404, ['Content-Length' => length($content)], [$content]];
        }
    };
}

my $tx = Text::Xslate->new(
    syntax => 'TTerse',
    module => ['Text::Xslate::Bridge::TT2Like'],
    path   => [__PACKAGE__->root . "/tmpl"],
    function => {
        c => sub { NoPaste::context() },
        uri_for => sub {
            my ( $path, $args ) = @_;
            my $req = NoPaste::context()->req();
            my $uri = $req->base;
            $uri->path( do {
                my $p = $uri->path . $path;
                $p =~ s!//!!;
                $p;
            } );
            $uri->query_form(@$args) if $args;
            $uri;
        },
    },
);
sub render {
    my ($self, @args) = @_;
    my $body = $tx->render(@args);
    $self->res->status(200);
    $self->res->content_type('text/html; charset=utf-8');
    $self->res->body(encode_utf8($body));
}

no Mouse;__PACKAGE__->meta->make_immutable;

