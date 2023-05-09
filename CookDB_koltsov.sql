create database CookDB;
use CookDB;

 drop table Composition_of_products;
 drop table Check_compositions;
 drop table Sale_check;
 drop table Menu_list;
 drop table Menu;
 drop table Product;

CREATE TABLE Product (
  ID int IDENTITY(1, 1) primary key,
  name varchar(75) not null,
  price float not null,
  count int not null,
  calories float,
  weight float
);

CREATE TABLE Menu (
  ID int IDENTITY(1, 1) primary key,
  price float not null DEFAULT (0),
  create_date date not null DEFAULT (CAST(GETDATE() AS Date)),
  preferential BIT not null default (1), 
);

CREATE TABLE Menu_list (
  menu_ID int REFERENCES Menu(ID) not null,
  product_ID int REFERENCES Product(ID) not null,
  count int not null
  UNIQUE(menu_ID, product_ID)
);

CREATE TABLE Sale_check (
  ID int primary key,
  price float not null DEFAULT(0),
  sdate date not null DEFAULT(CAST(GETDATE() AS Date))
);

CREATE TABLE Check_compositions (
  sale_ID int REFERENCES Sale_check(ID) not null,
  product_ID int REFERENCES Product(ID) not null,
  count int not null,
  UNIQUE (sale_ID, product_ID)
);

CREATE TABLE Composition_of_products (
  product_ID int REFERENCES Product(ID) not null,
  composition varchar(50) not null,
  weight float
);
