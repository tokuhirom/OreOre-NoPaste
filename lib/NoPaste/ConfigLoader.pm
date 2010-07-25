package NoPaste::ConfigLoader;
use strict;
use warnings;
use File::Spec;
use Cwd ();
use NoPaste;

sub load {
    my $class = shift;
    my $env = $ENV{PLACK_ENV} || 'development';
    my $fname = File::Spec->catfile(NoPaste->root(), 'config', "${env}.pl");
    my $conf = do $fname or die "Cannot load configuration file: $fname";
    return $conf;
}

1;

