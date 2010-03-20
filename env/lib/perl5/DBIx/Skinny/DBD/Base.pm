package DBIx::Skinny::DBD::Base;
use strict;
use warnings;
use DBIx::Skinny::SQL;

sub last_insert_id { $_[1]->func('last_insert_rowid') }

sub sql_for_unixtime { time() }

sub quote    { '`' }
sub name_sep { '.' }

sub bulk_insert {
    my ($skinny, $table, $args) = @_;

    my $txn; $txn = $skinny->txn_scope unless $skinny->attribute->{active_transaction} != 0;

        for my $arg ( @{$args} ) {
            $skinny->insert($table, $arg);
        }

    $txn->commit if $txn;

    return 1;
}

sub query_builder_class { 'DBIx::Skinny::SQL' }

1;

