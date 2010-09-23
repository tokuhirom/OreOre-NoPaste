use strict;
use warnings;
use NoPaste;
use DBIx::Skinny::Schema::Loader qw/make_schema_at/;
use FindBin;

my $c = NoPaste->bootstrap;
my $conf = $c->config->{'DBIx::Skinny'};

my $schema = make_schema_at( 'NoPaste::DB::Schema', {}, $conf );
my $dest = File::Spec->catfile($FindBin::Bin, '..', 'lib', 'NoPaste', 'DB', 'Schema.pm');
open my $fh, '>', $dest or die "cannot open file '$dest': $!";
print {$fh} $schema;
close $fh;
