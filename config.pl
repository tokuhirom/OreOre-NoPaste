{
    'M::DB' => {
        connect_info => [
            "dbi:SQLite:dbname=data/data.sqlite",
            '', '', { sqlite_unicode => 1 }
        ],
    },
    'V::MT' => { cache_mode => 6, },
};
