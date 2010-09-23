+{
    'DBIx::Skinny' => {
        dsn => 'dbi:mysql:database=dev_NoPaste',
        username => 'dev_NoPaste',
        password => 'd9ab8e01f4e7e7520dcb8e07dbcf35ae',
        connect_options => {
            mysql_enable_utf8 => 1,
        },
    },
    'Text::Xslate' => {
        path => ['tmpl/'],
    },
    'Log::Dispatch' => {
        outputs => [
            ['Screen',
            min_level => 'debug',
            stderr => 1,
            newline => 1],
        ],
    },
};
