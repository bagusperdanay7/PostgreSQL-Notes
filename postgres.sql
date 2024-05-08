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
