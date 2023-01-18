create database NETFLIX;

use NETFLIX;

CREATE TABLE Subscription_Plans  (
PlanID INT(10) NOT NULL,
PlanName VARCHAR(100) NOT NULL unique,
PlanPrice VARCHAR(100) NOT NULL,
PlanVideoQuality VARCHAR(100) NOT NULL,
CONSTRAINT Subscription_Plans_pk PRIMARY KEY (PlanID));

desc Subscription_Plans;

create table subscription(
subscription_id double not null AUTO_INCREMENT,
subscription_type varchar(100) not null,
price double not null,
start_date date not null, 
expiry_date date not null, 
CONSTRAINT subscription_pk PRIMARY KEY (subscription_id),
CONSTRAINT subscription_fk foreign key(subscription_type) references subscription_plans(PlanName)
);

desc Subscription;

create table Awards(
award_type  varchar(100) not null, 
award_name varchar(100) not null, 
constraint awards_pk primary key (award_type));

desc Awards;

create table content(
content_id int(20) not null auto_increment, 
title varchar(50) not null,
release_date date not null,
genre varchar(50) ,
imdb_rating float(10) ,
director_name varchar(50) , 
producer_name varchar(50) ,
run_time int(5) not null,
tvshows varchar(30) not null,
movies varchar(30) not null,
CONSTRAINT content_pk PRIMARY KEY (content_id));

desc content;

alter table content auto_increment=10001;

CREATE TABLE movie (
  MovieID int(10) NOT NULL auto_increment,
  Mname varchar(100) NOT NULL,
  Mduration int NOT NULL,
  mdirector_name varchar(30) DEFAULT NULL,
  mproducer_name varchar(30) DEFAULT NULL,
  maward varchar(30) DEFAULT NULL,
  award_year date DEFAULT NULL,
  mcontentid int(20),
  CONSTRAINT movie_pk PRIMARY KEY (MovieID),
  CONSTRAINT movie_fk FOREIGN KEY (maward) REFERENCES Awards (award_type) 
  ON DELETE CASCADE ON UPDATE CASCADE,
  constraint movie_fk2 foreign key(mcontentid) references content(content_id) 
  ON DELETE CASCADE ON UPDATE CASCADE);
  
desc movie;

alter table movie auto_increment=1001;

create table TVShows(
showID int(10) not null auto_increment,
showname varchar(100) not null, 
total_seasons int(10) ,
total_episodes varchar(30) not null,
episode_duration int(10),
show_director varchar(30),
show_producer varchar(30),
show_award varchar(30),
show_award_year date,
showcontentid int(20),
constraint tvshows_pk primary key (showID),
constraint tvshows_fk foreign key (show_award) references Awards(award_type) 
ON UPDATE CASCADE ON DELETE CASCADE,
constraint tvshows_fk2 foreign key(showcontentid) references content(content_id)
 ON UPDATE CASCADE ON DELETE CASCADE);
 
desc tvshows;

alter table tvshows auto_increment=5001; 

create table customer( 
CustID int(20) not null AUTO_INCREMENT,
cust_fname varchar(30) not null, 
cust_lname varchar(30) not null,
customer_email varchar(100) not null, 
address varchar(30) not null,
city varchar(20) not null,
state varchar(20) not null,
zipcode varchar(10) not null,
state_code varchar(20) ,
customer_phone double not null,
PlanID int(10) not null,
subscription_id double not null,
CONSTRAINT customer_pk PRIMARY KEY (CustID),
CONSTRAINT customer_fk FOREIGN KEY (PlanID) REFERENCES Subscription_Plans(PlanID) ON UPDATE CASCADE ON DELETE CASCADE,
constraint customer_fk2 foreign key(subscription_id) references subscription(subscription_id) ON UPDATE CASCADE ON DELETE CASCADE);

desc customer;

alter table customer auto_increment=1000000001;

create table payment(
payment_id int(30) not null auto_increment,
payment_method varchar(20) not null,
billing_date date not null,
amount float(10) not null, 
custid int(20) not null, 
subscription_id double  not null,
CONSTRAINT payment_pk PRIMARY KEY (payment_id),
CONSTRAINT payment_fk1 FOREIGN KEY (custid) REFERENCES customer (custid)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT payment_fk2 FOREIGN KEY (subscription_id) REFERENCES subscription (subscription_id)
ON DELETE CASCADE ON UPDATE CASCADE);

desc payment;

alter table payment auto_increment=12001;

create table actor(
actor_id double not null auto_increment,
actor_fname varchar(50) not null,
actor_lname varchar(50) not null,
DOB date, 
awards varchar(50),
constraint actor_pk primary key (actor_id),
CONSTRAINT actor_fk1 FOREIGN KEY (awards) REFERENCES awards (award_type)
ON DELETE CASCADE ON UPDATE CASCADE);

desc actor;

alter table actor auto_increment=100;

#inserting values into subscription plans table
insert into subscription_plans(planid, planname, planprice, planvideoquality) values 
(1, 'Basic', '9.99', '480p'),
(2,'Standard','15.49','1080p'),
(3,'Premium','19.99','4K UHD');

#Checking the table "subscription_plans" after the data is inserted
select * from subscription_plans;

#inserting values into subscription table
insert into subscription(subscription_type, price, start_date,expiry_date) values 
('Standard','19.99','2021-01-02','2021-02-01'),
('Basic','9.99','2021-05-31','2021-06-30'),
('Premium','19.99','2021-02-21','2021-03-23'),
('Premium','19.99','2021-12-17','2022-01-16'),
('Premium','19.99','2022-01-27','2022-02-26'),
('Basic','9.99','2022-02-13','2021-03-15'),
('Standard','15.49','2021-10-21','2021-11-20'),
('Basic','9.99','2021-12-17','2022-01-16'),
('Basic','9.99','2022-03-21','2022-04-20'),
('Premium','19.99','2022-04-30','2022-05-29'),
('Basic','9.99','2021-07-21','2021-08-20'),
('Basic','9.99','2021-02-21','2021-03-23'),
('Standard','15.49','2021-01-02','2021-02-01'),
('Premium','19.99','2022-01-26','2022-02-25'),
('Premium','19.99','2022-02-13','2021-03-15'),
('Standard','15.49','2021-09-21','2021-10-20'),
('Standard','15.49','2021-12-17','2022-01-16'),
('Basic','9.99','2022-03-21','2022-04-20'),
('Basic','9.99','2022-03-31','2022-04-30');

#Checking the table "subscription" after the data is inserted
select * from subscription;


insert into customer(cust_fname,cust_lname,address ,customer_email,customer_phone,city,state,zipcode,PlanID,subscription_id) values 
( 'Abhinay', 'Parasa', '1610 Holly Circle', 'aparasa@gmail.com', '9259996571', 'Pleasanton', 'California',94566, 3, 1),
( 'Krushi', 'Padamati', '40 Salisbury Way', 'kpadamati@gmail.com', '6413255770', 'Hayward', 'California',94542, 1, 2),
( 'Dileep',  'Kumar', '8 Janacourt', 'edkumar@yahoo.com', '5413255230',  'Fremont', 'California',94536, 1, 3),
( 'Kirsti', 'Gwillym', '8 OxfordCrossing', 'KirstiG@outlook.com', '5013259930', 'London', 'United Kingdom',5211, 2, 4),
( 'Terrence', 'Lewis', '5 DwereyPark', 'Terryrl@yahoo.com', '9112345876' , 'Scotsdale', 'Arizona',85054, 3, 5),
( 'Lazaro',  'Croster', '94542 Carlos Bee Blvd', 'Lazacross@yahoo.com', '3413259930', 'Hayward', 'California',94542, 3, 6),
( 'Hari',  'Rao', '333 ManhattanSt', 'hariprasad@yahoo.com', '2313259930', 'Queens', 'New York',11426, 2, 7),
( 'Naina', 'Reddy', '881 Fremont ln', 'nainareddy@gmail.com', '5123252113', 'Sunnyvale', 'California',94085, 2, 8),
( 'Samhitha', 'Reddy', '511 Newtown', 'reddysamhitha@yahoo.com', '2453259975', 'Jacksonville', 'Florida',32034, 1, 9),
( 'Anne',  'Watson', '1630 Holly Cir ', 'Annehw@yahoo.com', '8913259233', 'Pleasanton', 'California',94566, 1, 10),
('Iwette', 'David', '30 Autumnpark ', 'Iwetteb@yahoo.com', '7613253450', 'Seattle', 'Washington',98063, 2, 11),
('Paul', 'Hawkins', 'Melrosejunction', 'Stephenhawk@yahoo.com', '5012259321', 'Montreal', 'Quebec','H0HH9X', 1, 12),
('Olympie', 'Golborn', '22 Jasperst', 'Olympus@gmail.com', '6752593442', 'OlympGlb', 'Alabama',35242, 3, 13),
('Sam', 'Mane',   '912 BStreet,', 'Manesam@yahoo.com', '5589399391', 'San Jose', 'California',94088, 3, 14),
('Danna',  'Chatterjee', '65 Larrypoint', 'chatterjee@yahoo.com', '3213257938', 'Anchorage', 'Alaska',99501, 3, 15),
('Devon',  'Bollis', 'IndianSt,', 'dheerick@yahoo.com', '5338259956', 'Austin', 'Texas','73301', 1, 16),
('Val',  'Champken', '33 FlorenceStreet', 'champkenval@yahoo.com', '4453251976', 'Berlin', 'Germany',14199, 2, 17),
('Melanie', 'Clinton', 'Nottinghill', 'melaniec@yahoo.com', '5313256630', 'Brooklyn', 'New York', 11207, 1, 18),
('Rowela',  'Johnson', 'Elak lane,', 'johnsonowela@yahoo.com', '5119859965', 'Cleveland', 'Ohio',44101, 1, 19),
('Pooja', 'Agarwal', '221 Fremont', 'Poojaagarwal@yahoo.com', '4323257632', 'Fremont', 'California',94536, 3, 20);

#Checking the table "customer" after the data is inserted
select * from customer;

insert into awards(award_type,award_name) values
('best_actor', 'Best Actor'),
('best_actress', 'Best Actress'),
('best_director','Best Director'),
('best_music', 'Best Music Director'),
('best_screenplay', 'Best TV Show Actress'),
('best_effects','Best Visual Effects'),
('best_bol', 'Best Background Original Score'),
('best_cdesign', 'Best Costume Design'),
('best_aff','Best Animated Feature Film'),
('best_editing','Best Edting'),
('best_FLF','Best Foreign Language Film');

#Checking the table "awards" after the data is inserted
select * from awards;

insert into payment(payment_method,billing_date,amount,CustID,subscription_id) values
('Visa','2021-01-02','19.99',1000000001,1),
('Master','2021-05-31','9.99',1000000002,2),
('Discover','2021-02-21','19.99',1000000003,3),
('Visa','2021-12-17','19.99',1000000004,4),
('Master','2022-01-27','19.99',1000000005,5),
('Discover','2022-02-13','9.99',1000000006,6),
('Visa','2021-10-21','15.49',1000000007,7),
('Master','2021-12-17','9.99',1000000008,8),
('Discover','2022-03-21','9.99',1000000009,9),
('Visa','2022-04-30','19.99',1000000010,10),
('Master','2022-04-30','19.99',1000000011,11),
('Discover','2021-07-21','9.99',1000000012,12),
('Visa','2021-02-21','9.99',1000000013,13),
('Master','2021-01-02','19.99',1000000014,14),
('Discover','2022-01-26','19.99',1000000015,15),
('Visa','2022-02-13','19.99',1000000016,16),
('Master','2021-09-21','15.49',1000000017,17),
('Discover','2021-12-17','15.49',1000000018,18),
('Visa','2022-03-21','9.99',1000000019,19),
('Master','2022-03-31','9.99',1000000020,20);

#Checking the table "payment" after the data is inserted
select * from payment;

#inserting values into actor table
insert into actor(actor_fname, actor_lname, DOB) values 
('Amber','Heard','1986-04-22'),
('Jason','Momoa','1979-08-01'),
('Channing','Tatum','1980-04-26'),
('Alexandra','Daddario','1986-03-16'),
('Angelina','Jolie','1975-06-04'),
('Kristen','Stewart','1990-04-09'),
('Tom','Cruise','1962-07-03'),
('Kevin','Hart','1979-07-06'),
('Chadwick','Boseman','1976-11-29'),
('Tom','Holland','1996-06-01'),
('Tom','Hiddleston','1981-02-09'),
('Jennifer','Aniston','1969-02-11');

#Checking the table "actor" after the data is inserted
select * from actor;

#Inserting data into movie table
insert into movie(Mname, Mduration,mcontentid ) values
('The Adam Project','140', 10001),
('The Social Network','120',10002 ),
('Spectre','135',10003),
('Rambo','91',10004),
('83','160', 10016),
('Rambo: Last Blood','89', 10017),
('Sanju','158',10018),
('Veronica','105',10007),
('The Conjuring','111', 10008),
('Alive','98' ,10010),
('Annabelle Creation','109', 10011),
('The Silence','90', 10012),
('The Ritual','94', 10013);	

#Checking the table "movie" after the data is inserted
select * from tvshows;

#Inserting data into tvshows table
insert into tvshows( showname, total_seasons, total_episodes, episode_duration, show_director, Show_producer, 
show_award, show_award_year, showcontentid) values
('Ozark', 3 , 44, '60', 'Adam', 'Ben', 'best_actor', '1997-01-12', 10014),
('Space Force', 1, 3, '30', 'Rock', 'Hill', 'best_director', '2020-02-11', 10015),
('Stranger Things','2', 10 , '40', 'Jazero', 'Laura', 'best_music', '2011-03-09', 10005),
('The Vampire Dairies','10', 30, '75', 'Robin', 'Christine', 'best_aff', '2012-04-10', 10019),
('Flash', 5 , 50, '25', 'Bill', 'Tim', 'best_actor', '2022-06-16', 10020),
('Arrow', 7 , 70, '35', 'Obama', 'Cook', 'best_music', '2000-11-19', 10021),
('Money Heist', 3 , 30, '40', 'Trump', 'Brook', 'best_actress', '1998-12-12', 10006),
('Lucifer', 6 , 60, '60', 'Treudeu', 'Modi', 'best_effects', '2015-01-31', 10009),
('Squid Game', 9, 25, '70', 'Michel', 'Jagan', 'best_bol', '2018-05-30', 10022);

#Checking the table "tvshows" after the data is inserted
select * from tvshows;

#Inserting data into content table
insert into content(title,release_Date,genre,imdb_rating,director_name,producer_name,run_time,tvshows,movies) values
('The Adam Project','2022-03-09','Adventure','6.7','Bill','John','140','N','Y'),
('The Social Network','2010-12-11','History','7.8','Stefan','Peterson','120','N','Y'),
('Spectre','2018-01-21','Sci-fi','7','Andy','Peterman','135','N','Y'),
('Rambo','2009-11-30','Action','6.9','Robert','Joseph','91','N','Y'),
('Stranger Things','2010-12-11','Horror','8.4','Jazero', 'Laura','25','Y','N'),
('Money Heist','2019-04-29','Thirller','7.9','Trump', 'Brook','48','Y','N'),
('Veronica','2020-10-12','Horror','6.1','Klark','Andrew','105','N','Y'),
('The Conjuring','2017-07-19','Horror','6.1','Bruce','Alfred','111','N','Y'),
('Lucifer','2016-11-30','Drama','8','Treudeu', 'Modi',93,'Y','N'),
('Alive','2013-02-25','Adventure','5.9','Jarvis','Richard','98','N','Y'),
('Annabelle Creation','2017-08-19','Horror','6.7','Connor','David','109','N','Y'),
('The Silence','2018-05-21','Horror','6.7','Cook','Warner','90','N','Y'),
('The Ritual','2018-11-29','Horror','7.1','Mitchell','Stark','94','N','Y'),
('Ozark','2015-07-21','Drama','7','Adam', 'Ben',44,'Y','N'),
('Space Force','2018-09-21','Comedy','7.8','Rock','Hill', 17,'Y','N'),
('83','2015-07-21','Drama','6.3','Ranveer','Shahrukh','160','N','Y'),
('Rambo: Last Blood','2013-01-31','Action','5.8','Robert','Daemon','89','N','Y'),
('Sanju','2020-11-21','Drama','6.9','Aamir','Karan','158','N','Y'),
('The Vampire Dairies','2008-11-11','Horror','7.8','Robin', 'Christine','171','Y','N'),
('Flash','2007-11-28','Drama','7.5','Bill', 'Tim','151','Y','N'),
('Arrow','2008-12-11','Drama','7.3','Obama', 'Cook','170','Y','N'),
('Squid Game','2021-03-11','Thriller','8.1','Michel', 'Jagan',9,'Y','N');

#Checking the table "content" after the data is inserted
select * from content;

#Join query to get subscription date less than 2021-10-01
SELECT 
    c.custid,
    c.cust_fname,
    c.state,
    c.zipcode,
    s.subscription_type,
    s.price,
    s.Start_Date
FROM
    customer c
        JOIN
    subscription s ON c.subscription_id = s.subscription_id
        JOIN
    payment p ON s.subscription_id = p.subscription_id
WHERE
    p.billing_date < '2021-10-01';


#Query to fetch the customers who has Basic plan
SELECT 
    c.custid,
    c.cust_fname,
    c.customer_phone,
    p.payment_method,
    p.billing_date,
    p.amount,
    sp.planname
FROM
    customer c
        JOIN
    payment p ON c.custid = p.custid
        JOIN
    subscription s ON p.subscription_id = s.subscription_id
        JOIN
    subscription_plans sp ON s.subscription_type = sp.planname
WHERE
    planname = 'Basic';

#Cross joning 4 tables
SELECT 
    *
FROM
    customer
        JOIN
    payment
        JOIN
    subscription
        JOIN
    subscription_plans;
    
#Create view for California customers having basic plan
CREATE VIEW CaliBasic AS
    SELECT 
        c.custid, c.cust_fname, c.cust_lname, s.subscription_type
    FROM
        customer c
            JOIN
        subscription s ON c.subscription_id = s.subscription_id
            JOIN
        subscription_plans sp ON s.subscription_type = sp.planname
    WHERE
        c.state = 'California'
            AND sp.planname = 'Basic';
            
select * from calibasic;

#Creating a view to see all users having all type subscription that are not from California
CREATE VIEW NonCaliUsers AS
    SELECT 
        c.custid,
        c.cust_fname,
        c.cust_lname,
        c.state,
        s.subscription_type
    FROM
        customer c
            JOIN
        subscription s ON c.subscription_id = s.subscription_id
            JOIN
        subscription_plans sp ON s.subscription_type = sp.planname
    WHERE
        c.state != 'California';
        
SELECT * FROM NonCaliUsers;

#Stored Procedure for payment greater than $10
DELIMITER //
CREATE PROCEDURE payment()
BEGIN
sELECT c.cust_fname,c.cust_lname,p.payment_id, p.custid, p.amount, p.subscription_id FROM
		payment p join customer c on p.custid=c.custid
	WHERE p.amount >'10'
    ORDER BY p.amount ;   
END//
DELIMITER ;

call payment;

#Stored Procedure for content having rating greater than 6.5
DELIMITER //
CREATE PROCEDURE ContentRating()
BEGIN
SELECT * from content 
	WHERE imdb_rating>'6.5'
    ORDER BY imdb_rating ;   
END//
DELIMITER ;

call ContentRating;

