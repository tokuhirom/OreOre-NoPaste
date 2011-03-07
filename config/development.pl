# GRANT ALL PRIVILEGES ON dev_NoPaste.* TO dev_NoPaste@localhost IDENTIFIED BY 'd9ab8e01f4e7e7520dcb8e07dbcf35ae';
+{
    'DBI' => [
        'dbi:mysql:database=dev_NoPaste',
        'dev_NoPaste',
        'd9ab8e01f4e7e7520dcb8e07dbcf35ae',
    ],
    'Text::Xslate' => {
        path => ['tmpl/'],
    },
};
