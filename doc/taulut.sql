create table users
(
	id integer not null primary key unique autoincrement ,
	username varchar(30) not null,
	password varchar(100) not null,
	role integer not null
)

create table topics
(
	id integer not null primary key unique autoincrement,
	topic varchar(200) not null,
	userid varchar(30) not null foreign key references users(id),
	posttime timestamp not null default current_timestamp,
)

create table messages
(
	id integer not null primary key unique autoincrement,
	topicid integer not null foreign key references topics(id),
	message varchar(1000) not null,
	userid integer not null foreign key references users(id),
	posttime datetime not null,
)