package OreOre::NoPaste::M::DB;
use Mouse;
use DBI;

has dsn => (
    is => 'ro',
    isa => 'ArrayRef',
    required => 1,
);

has 'dbh' => (
    is       => 'ro',
    lazy     => 1,
    default  => sub {
        my $self = shift;
        DBI->connect( @{ $self->dsn } );
    },
);

1;
