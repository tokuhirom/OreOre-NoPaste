package NoPaste::DB::Schema;
use DBIx::Skinny::Schema;

install_table entry => schema {
    pk qw/entry_id/;
    columns qw/entry_id body timestamp/;
};

1;