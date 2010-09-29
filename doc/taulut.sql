create table users
(
	id integer not null primary key unique,
	username varchar(30) not null,
	password varchar(100) not null,
	role integer not null default 0
);

create table topics
(
	id integer not null primary key unique,
	topic varchar(200) not null,
	userid varchar(30) not null,
	posttime timestamp not null default current_timestamp,
        foreign key (userid) references users(id)
);

create table messages
(
	id integer not null primary key unique,
	topicid integer not null,
	message varchar(1000) not null,
	userid integer not null,
	posttime timestamp not null default current_timestamp,
        foreign key (topicid) references topics(id),
        foreign key (userid) references users(id)
);

//foreign key p‰‰lle t‰ll‰ komennolla, (defaulttina pois sqlitess‰)
//PRAGMA foreign_keys = ON;


//insert into users (username, password) values ('Jorma', 'salis');
//insert into topics (topic, userid) values ('Eka topic!!', 1);
//insert into messages (topicid, message, userid) values (1,'t‰‰ on ekan topicin eka viesti!!!', 1);