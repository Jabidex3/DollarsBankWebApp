create database bankapp;
use bankapp;

create table customer (
c_id int auto_increment,
cname varchar(30),
address varchar(50),
phone varchar(10),
username varchar(30),
pass varchar(30),
primary key(c_id)
);

create table accounts(
c_id int,
balance double,
primary key(c_id),
foreign key(c_id) references customer(c_id)
);

create table transactions(
t_id int auto_increment,
c_id int,
user_transaction varchar(200),
primary key(t_id),
foreign key(c_id) references customer(c_id)
);