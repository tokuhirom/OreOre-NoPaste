create table if not exists entry (
    id varchar(36) not null primary key,
    body longblob not null
) engine=innodb;
