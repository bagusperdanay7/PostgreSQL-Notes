select * from pg_tables where schemaname='public';

create table barang(
    kode int not null ,
    name varchar(100) not null,
    harga int not null default 1000,
    jumlah int not null default 0,
    waktu_dibuat timestamp not null default current_timestamp
);

alter table barang
add column deskripsi text;

alter table barang
drop column deskripsi;

alter table barang
rename column name to nama;

truncate barang;

drop table barang;

create table products(
    id varchar(10) not null ,
    name varchar(100) not null,
    description text,
    price int not null ,
    quantity int not null default 0,
    created_at timestamp not null default current_timestamp
);

insert into products(id, name, price, quantity)
values('P0001', 'Mie Ayam Original', 15000, 100);

insert into products(id, name, description, price, quantity)
values('P0002', 'Mie Ayam Bakso Tahu', 'Mie Ayam Original + Bakso Tahu', 20000, 100);

insert into products(id, name, price, quantity)
values ('P0003', 'Mie Ayam Ceker', 20000, 100),
       ('P0004', 'Mie Ayam Spesial', 25000, 100),
       ('P0005', 'Mie Ayam Yamin', 15000, 100);

select * from products;

select id, name, price, quantity from products;

alter table products
    add primary key (id);

select id, name, price, quantity
from products
where quantity = 0;

select id, name, price, quantity
from products
where price = 20000;

select id, name, price, quantity
from products
where id = 'P0004';

select * from products;

create type PRODUCT_CATEGORY as enum ('Makanan', 'Minuman', 'Lain-Lain');

alter table products
    add column category PRODUCT_CATEGORY;

update products
set category = 'Makanan'
where id = 'P0001';

update products
set category = 'Makanan'
where id = 'P0002';

update products
set category = 'Makanan'
where id = 'P0003';

update products
set category = 'Makanan'
where id = 'P0004';

update products
set category = 'Makanan'
where id = 'P0005';

update products
set category = 'Makanan',
    description = 'Mie Ayam + Ceker'
where id = 'P0003';

select * from products;

update products
set price = price + 5000
where id = 'P0004';

insert into products(id, name, price, quantity, category)
values ('P0009', 'Contoh', 10000, 100, 'Minuman');

delete from products
where id = 'P0009';

select id as "Kode Barang", price as "Harga Barang", description as "Deskripsi Barang" from products;

select p.id as "Kode Barang",
       p.price as "Harga Barang",
       p.description as "Deskripsi Barang"
from products as p;

select * from products where price > 15000;

select * from products where price <= 15000;

select * from products where category != 'Minuman';

select * from products where price > 15000 and category = 'Minuman';

select * from products;

insert into products(id, name, price, quantity, category)
values ('P0006', 'Es Teh Tawar', 10000, 100, 'Minuman'),
       ('P0007', 'Es Campur', 20000, 100, 'Minuman'),
       ('P0008', 'Jus Jeruk', 15000, 100, 'Minuman');

select * from products where price > 15000 or category = 'Makanan';

select * from products where quantity > 100 or category = 'Makanan' and price > 15000;

select * from products where category = 'Makanan' or (quantity > 100 and price > 15000);

select * from products where name ilike '%es%';

select * from products where description is null;

select * from products where description is not null;

select * from products where price between 10000 and 20000;

select * from products where price not between 10000 and 20000;

select * from products where category in ('Makanan', 'Minuman');

select * from products order by price asc, id desc;

select * from products where price > 0 order by price asc, id desc limit 2;

-- 1: limit 2 offset 0, 2: limit 2 offset 2, 3: limit 2 offset 4
select * from products where price > 0 order by price asc, id desc limit 2 offset 2;

select category from products;

select distinct category from products;

select 10 + 10 as hasil;

select id, name, price / 1000 as price_in_k from products;

select pi();

select power(10,2);

select cos(10), sin(10), tan(10);

select id, name, power(quantity, 2) as quantity_power_2 from products;

create table admin
(
    id serial not null,
    first_name varchar(100) not null,
    last_name varchar(100),
    primary key (id)
);

insert into admin(first_name, last_name)
values ('Eko', 'Khannedy'),
       ('Budi', 'Nugroho'),
       ('Bagus', 'Perdana');

select * from admin;

select currval('admin_id_seq');

-- Membuat sequence
create sequence contoh_sequence;

-- Memanggil sequence, otomatis increment
select nextval('contoh_sequence');

-- Mengambil nilai terakhir sequence
select currval('contoh_sequence');

select id, name, description from products;

select id, lower(name), length(name), lower(description) from products;

select id, extract(year from created_at), extract(month from created_at) from products;

select id,
       category,
       case category
            when 'Makanan' then 'Enak'
            when 'Minuman' then 'Seger'
            else 'Apa itu?'
        end as category_case
from products;

select id,
       price,
       case
           when price <= 15000 then 'Murah'
           when price <= 20000 then 'Mahal'
           else 'Mahal Banget'
           end as "Apakah murah?"
from products;

select id,
       name,
       case
           when description is null then 'Kosong'
           else description
           end as description
from products;

select count(id) from products;

select avg(price) from products;

select max(price) from products;

select min(price) from products;

select category, count(id) as "Total Product" from products group by category;

select category,
       avg(price) as "Rata Rata Harga",
       min(price) as "Harga Termurah",
       max(price) as "Harga Termahal"
from products
group by category;

select category, count(id) as "Total Product"
from products
group by category
having count(id) > 3;

select category,
       avg(price) as "Rata Rata Harga",
       min(price) as "Harga Termurah",
       max(price) as "Harga Termahal"
from products
group by category
having avg(price) >= 20000;

create table customer
(
    id         serial       not null,
    email      varchar(100) not null,
    first_name varchar(100) not null,
    last_name  varchar(100),
    primary key (id),
    constraint unique_email unique (email)
);

insert into customer(email, first_name, last_name)
values ('baguspyus@gmail.com', 'Bagus', 'Yusuf');

select * from customer;

insert into customer(email, first_name, last_name)
values ('budi@gmail.com', 'Budi', 'Nugroho'),
       ('eko@pzn.com', 'Eko', 'Khannedy'),
       ('joko@pzn.com', 'Joko', 'Morro');

alter table customer
drop constraint unique_email;

alter table customer
add constraint unique_email unique (email);

create table products
(
    id          varchar(100) not null,
    name        varchar(100) not null,
    description text,
    price       int          not null,
    quantity    int          not null,
    created_at  timestamp    not null default current_timestamp,
    primary key (id),
    constraint price_check check ( price >= 1000 )
);

alter table products add constraint price_check check (price > 1000);

alter table products add constraint quantity_check check (quantity >= 0);

insert into products(id, name, price, quantity, category)
values ('XXX1', 'Contoh Gagal', 10, 8, 'Minuman');

insert into products(id, name, price, quantity, category)
values ('XXX1', 'Contoh Gagal', 10000, -10, 'Minuman');

select * from products;

create table sellers
(
    id  serial  not null,
    name varchar(100) not null,
    email varchar(100) not null,
    primary key (id),
    constraint email_unique unique (email)
);

alter table sellers
add constraint email_unique unique (email);

insert into sellers(name, email)
values ('Gallery O', 'galleryobesar@gmail.com'),
       ('Toko Budi', 'tokobudy@gmail.com'),
       ('Toko Rully', 'rullyshop@pzn.com'),
       ('BinShop', 'contact@binshop.com');

SELECT * FROM sellers;

create index sellers_id_and_name_index on sellers (id,name);
create index sellers_email_and_name_index on sellers (email,name);
create index sellers_name_index on sellers (name);

select * from sellers where id = 1;
select * from sellers where id = 1 or name = 'Toko Budi';
select * from sellers where email = 'contact@binshop.com' or name = 'Toko Rully';
select * from sellers where name = 'Toko Rully';

select * from products
where name ilike '%mie%';

select * from products
where to_tsvector(name) @@ to_tsquery('mie');

-- mengambil bahasa yang tersedia
select cfgname from pg_ts_config;

create index products_name_search on products using gin (to_tsvector('indonesian', name));
create index products_description_search on products using gin (to_tsvector('indonesian', description));

select * from products where name @@ to_tsquery('mie');
select * from products where description @@ to_tsquery('mie');

select * from products where name @@ to_tsquery('mie & ayam');
select * from products where name @@ to_tsquery('''ayam bakso''');

create table wishlist
(
    id  serial  not null,
    id_product varchar(10) not null,
    description text,
    primary key (id),
    constraint fk_wishlist_product foreign key (id_product) references products (id)
);

insert into wishlist(id_product, description)
    values ('P0001', 'Mie Ayam Kesukaan'),
			('P0002', 'Mie Ayam Kesukaan'),
			('P0005', 'Mie Ayam Kesukaan');

delete from products where id = "P0005";

alter table wishlist
drop constraint fk_wishlist_product;

alter table wishlist
add constraint fk_wishlist_product foreign key (id_product) references products (id)
on delete cascade on update cascade;

insert into products(id, name, price, quantity, category)
values ('XXX', 'Xxx', 10000, 100, 'Minuman');

select * from products;

insert into wishlist(id_product, description) values ('XXX', 'Contoh');

select * from wishlist;

delete from products where id = 'XXX';