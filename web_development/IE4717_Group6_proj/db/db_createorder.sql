use f38_dg06;

create table orders 
(
    orderid int unsigned not null auto_increment primary key,
    username varchar(50) not null,
    total_qty int unsigned not null,
    total_price float not null,
    products int unsigned not null,
    shipping varchar(20) not null,
    deli_address text,
    deli_postal varchar(10),
    deli_contact varchar(10),
    bill_address text,
    bill_postal varchar(10)
);