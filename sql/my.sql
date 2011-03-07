create table entry (
    entry_id varchar(36) binary not null,
    body longtext not null,
    timestamp timestamp not null,
    PRIMARY KEY (entry_id)
) engine=innodb DEFAULT CHARSET=utf8;
