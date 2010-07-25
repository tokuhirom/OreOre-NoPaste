+{
    'Log::Dispatch' => {
        outputs => [
            [ 'Screen', min_level => 'warning' ],
        ]
    },
    DB => {
        dsn             => 'dbi:SQLite:dbname=db/db.sqlite',
        username        => '',
        password        => '',
        connect_options => +{ sqlite_unicode => 1, },
    },
}
