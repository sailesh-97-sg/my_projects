use f38_dg06;
/*  please use include "dbconnect.php" to connect to database.
    It will make easier to change database name, user name on different workstation.
    Admin username - admin
    Admin password - fashionspot*/
create table users 
(
    username varchar(50) not null primary key,
    password varchar(100) not null,
    email varchar(50) not null,
    contact varchar(10),
    address text,
    postal varchar(10)
);

create table products
(   productname char(50) not null primary key,
    producttag char(50) not null,
    productprice float unsigned not null,
    productimage char(100),
    productdescription varchar(500)
);

insert into products values 
("Fashion C1", "Casual", 12.00, "../assets/casual1.jpg", "This is the first shirt in the Fashion C series of clothings. The C series stands for Casual, and the material for the clothes in this series are full-cotton, meant to bring utmost comfort to the wearer."),
("Fashion C2", "Casual", 15.50, "../assets/shirt1.jpg", "As the second shirt released in the Fashion C series, this is a significant upgrade over the first model of the shirt. This shirt is designed to be even more comfortable as compared to the first, and is also designed by the famous fashion designer Marc Jacobs in June 2022, making it an easy choice for those looking for casual, comfortable wear."),
("Fashion X1", "Dry-Fit", 13.00, "../assets/dryfit1.jpg", "This is the first shirt that is released in the Fashion X series, where the X is representative of the collaboration between FashionStore and Xtreme Sports. This dry-fit shirt is meant to be breathable for users and is comfortable to the touch. "),
("Fashion X2", "Dry-Fit", 14.50, "../assets/clothe1.jpg", "This is the second and newly upgraded dry-fit shirt of our X series. This is a significant improvement over the previous model, with better meshing and increased breathability of the clothings. It is also made using the highest quality of materials which are meant to last for a long time."),
("Fashion B1", "Shirts", 22.00, "../assets/shirt01.jpg", "This is first of our B series lineup, focused more towards business-minded individuals hoping to make an impact in terms of presenting themselves in the workplace. Designed by the famous designer Antonio, this is guaranteed to let you impress those around you."),
("Fashion B2", "Shirts", 24.00, "../assets/shirt02.jpg", "This is the second of our B series, which comes in a different color from the original."),
("Fashion B3", "Shirts", 25.00, "../assets/shirt03.jpg", "This is the final shirt in our B series lineup, which was one of our most popular series in the past month.");

insert into users values 
('admin', md5('fashionspot'), 'admin@fashionspot.com', '12345678', '50 Nanyang Ave', '639798');