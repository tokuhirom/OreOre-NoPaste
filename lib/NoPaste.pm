package NoPaste;
use Mouse;
use NoPaste::ConfigLoader;
use Cwd ();
use NoPaste::DB;
use constant +{
    is_devel => $ENV{PLACK_ENV} eq 'development' ? 1 : 0,
};

has config => (
    is       => 'ro',
    isa      => 'HashRef',
    required => 1,
);

has db => (
    is      => 'ro',
    isa     => 'NoPaste::DB',
    lazy    => 1,
    default => sub {
        my $self = shift;
        my $conf = $self->config->{'DB'} || die "missing configuration for DB";
        NoPaste::DB->new($conf);
    },
);


my $root = do {
    my $p = __FILE__;
    $p = Cwd::abs_path($p) || $p;
    (my $q = __PACKAGE__) =~ s{::}{/}g;
    $p =~ s{$q\.pm$}{};
    $p =~ s{/lib/?$}{}g;
    $p =~ s{/blib/?$}{}g;
    $p;
};
sub root { $root }

sub context { die "cannot find context" }

sub bootstrap {
    my ($class) = @_;
    my $c = $class->new(config => NoPaste::ConfigLoader->load);
    no warnings 'redefine';
    *NoPaste::context = sub { $c };
    return $c;
}

sub db {
    my ($self) = @_;
    $self->{db} ||= do {
        NoPaste::DB->new($self->config->{'DB'});
    };
}

no Mouse; __PACKAGE__->meta->make_immutable;

