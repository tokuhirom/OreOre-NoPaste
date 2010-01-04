package OreOre::NoPaste;
use Amon -base;
use 5.010;

our $VERSION = '0.10';

__PACKAGE__->add_factory(
    'DB' => 'DBI'
);

1;
