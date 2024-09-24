# Tutorial PostgreSQL Database

Kode ini merupakan materi PostgreSQL yang dibawakan oleh **Eko Kurniawan Khannedy** dari channel YouTube _Programmer Zaman Now_.

Link Tutorial: [Video](https://www.youtube.com/watch?v=iEeveYoD0SA)

Bahasan Materi Meliputi:

- Pengenalan Sistem Basis Data
- Pengenalan PostgreSQL
- Menginstall PostgreSQL
- Database
- Tipe Data
- Tipe Data Number
- Tipe Data String
- Tipe Data Date dan Time
- Tipe Data Boolean
- Tipe Data Enum
- TIpe Data Lainnya
- Table
- Insert Data
- Select Data
- Primary Key
- Where Clause
- Update Data
- Delete Data
- Alias
- Where Operator
- Order By Clause
- Limit Clause
- Select Distinct Data
- Numeric Function
- Auto Increment
- Sequence
- String Function
- Date dan Time Function
- Flow Control Function
- Aggregate Function
- Grouping
- Constraint
- Index
- Full Text Search
- Table Relationship
- Join
- One to One Relationship
- One to Many Relationship
- Many to Many Relationship
- Jenis Jenis Join
- Subqueries
- Set Operator
- Transaction
- Locking
- Schema
- User Management
- Backup Database
- Restore Database

## Technology stack & Tools

**Program ini membutuhkan:**

| Language & Library | Version |
| ------------------ | ------- |
| PostgreSQL         | 15.5+   |
| pgAdmin 4          | 7.0+    |

## Catatan Pribadi

Jika ingin klona di komputer lain. Taruh di direktori berikut:

    .
    ├── Course
    │   ├── Programmer Zaman Now
    |   |   ├── POSTGRESQL
    |   |   └── ...
    |   └── ...
    └── ...

Jika sudah di berada di folder **POSTGRESQL**, baru clone.

```sh
git clone https://github.com/bagusperdanay7/PostgreSQL-Notes.git
```

# Notes

Ini merupakan catatan pribadi mengenai materi dari **PostgreSQL** Database dengan Pak _Eko Kurniawan Khannedy_.

## Mengunakan PostgreSQL Pertama kali

Masukkan syntax berikut di terminal, sesuaikan `--username` dan `--password` nya.

```shell
psql --host=localhost --port=5432 --username=user --password
psql --host=localhost --port=5432 --dbname=belajar_restore --username=user --password
```

## Melihat Semua Database

Untuk melihat semua database gunakan `\l` atau command di bawah ini

```sql
select datname from pg_database;
```

## Membuat Database Baru

`nama_database` diisi dengan nama database yang diinginkan

```sql
create database nama_database;
```

## Menghapus Database

`nama_database` diisi dengan nama database yang diinginkan

```sql
drop database nama_database;
```

## Menggunakan Database

```console
\c namadatabase
```

## Melihat Table

```sql
select * from pg_tables where schemaname = 'public';
```

## Membuat Table

```sql
create table barang(
    kode int,
    name varchar(100),
    harga int,
    jumlah int
);
```

## Melihat Detail Table

```console
\d barang
```

## Mengubah Table

Jika Menambah Column

```sql
alter table barang
add column deskripsi text;
```

Menghapus Column

```sql
alter table barang
drop column deskripsi;
```

Jika

### Mengubah Nama Column

```sql
alter table barang
rename column name to nama;
```

## Default Value & Null Value

Ketika kita ingin membuat suatu kolom nilainya tidak boleh kosong gunakan kata kunci `NOT NULL`. Jika ingin nilai bawaan (defaultnya) terisi jika tidak diisi, maka gunakan kata kunci `default`.

```sql
create table barang(
    kode int not null ,
    name varchar(100) not null,
    harga int not null default 1000,
    jumlah int not null default 0,
    waktu_dibuat timestamp not null default current_timestamp
);
```

## Membuat Ulang Table

```sql
truncate barang;
```

## Menghapus Table

```sql
drop table barang;
```

## Memasukkan Data (Insert)

### Memasukkan Data Single

```sql
insert into products(id, name, price, quantity)
values('P0001', 'Mie Ayam Original', 15000, 100);
```

### Memasukkan Banyak Data

```sql
insert into products(id, name, price, quantity)
values ('P0003', 'Mie Ayam Ceker', 20000, 100),
       ('P0004', 'Mie Ayam Spesial', 25000, 100),
       ('P0005', 'Mie Ayam Yamin', 15000, 100);
```

## Melihat / Menyeleksi Data (Select)

### Melihat Semua Data dan Semua Kolom

```sql
select * from products;
```

### Melihat Semua data dan hanya beberapa kolom

```sql
select id, name, price, quantity from products;
```

## Primary Key

Primary key biasanya bersifat unik, Primary Key adalah sebuah kolom yang kita tunjuk sebagai id dari table tersebut. Primary key bisa merujuk beberapa kolom, namun disarankan hanya satu kolom saja.

### Menambahkan Primary Key di Tabel

```sql
create table products(
    id varchar(10) not null ,
    name varchar(100) not null,
    description text,
    price int not null ,
    quantity int not null default 0,
    created_at timestamp not null default current_timestamp,
    primary key (id)
);
```

### Menambahkan Primary Key di Tabel (Alter)

```sql
alter table products
    add primary key (id);
```

## Where Clause

Contoh 1 (Seleksi Number)

```sql
select id, name, price, quantity
from products
where price = 20000;
```

Contoh 2 (Seleksi String)

```sql
select id, name, price, quantity
from products
where id = 'P0004';
```

## Update Data

**Menambah Kolom Kategori Terlebih Dahulu**

```sql
create type PRODUCT_CATEGORY as enum ('Makanan', 'Minuman', 'Lain-Lain');

alter table products
    add column category PRODUCT_CATEGORY;
```

### Mengubah data Satu Kolom

```sql
update products
set category = 'Makanan'
where id = 'P0001';
```

### Mengubah Data Beberapa Kolom

```sql
update products
set category = 'Makanan',
    description = 'Mie Ayam + Ceker'
where id = 'P0003';
```

### Mengubah data dengan Value di Kolom

```sql
update products
set price = price + 5000
where id = 'P0004';
```

## Menghapus Data (Delete)

```sql
delete from products
where id = 'P0009';
```

## Alias

### Alias untuk Kolom

```sql
select id as "Kode Barang", price as Harga, description as Deskripsi from products;
```

### Alias untuk Table

```sql
select p.id as "Kode Barang",
       p.price as "Harga Barang",
       p.description as "Deskripsi Barang"
from products as p;
```

## Where Operator

Where dengan operator perbandingan

### Operator Lebih Dari (>)

```sql
select * from products where price > 15000;
```

### Operator Kurang Dari Sama Dengan (<=)

```sql
select * from products where price <= 15000;
```

### Operator Tidak Sama Dengan (!=)

```sql
select * from products where category != 'Minuman';
```

### Operator AND

Untuk Operasi AND kedua kondisi harus benar, jika salah satu salah maka akan bernilai salah (false)

```sql
select * from products where price > 15000 and category = 'Minuman';
```

### Operasi OR

Untuk Operasi OR, Jika salah satu kondisi terpenuhi, maka akan tetap muncul. Kecuali jika keduanya `false`

```sql
select * from products where price > 15000 or category = 'Makanan';
```

### Prioritas dengan Kurung ()

```sql
select * from products where category = 'Makanan' or (quantity > 100 and price > 15000);
```

### LIKE Operator

Kata kunci `LIKE` case sensitif, jika ingin mencari incase sensitif gunakan kata kunci `ILIKE`.

| LIKE Operator |                         Hasil                         |
| ------------- | :---------------------------------------------------: |
| LIKE 'b%'     |                String dengan awalan b                 |
| LIKE '%a'     |                String dengan akhiran b                |
| LIKE '%eko%'  | String berisi eko tanpa peduli depan atau belakangnya |
| NOT LIKE      |                      Tidak LIKE                       |

---

```sql
select * from products where name ilike '%es%';
```

### NULL Operator

Mencari null operator tidak bisa menggunakan operator perbandingan = NULL, Hanya ada dua, yaitu `IS NULL` dan `IS NOT NULL`.

```sql
-- null
select * from products where description is null;

-- tidak null
select * from products where description is not null;
```

### BETWEEN Operator

Terdapat operator `BETWEEN` dan `NOT BETWEEN`.

```sql
-- diantara
select * from products where price between 10000 and 20000;

-- tidak diantara
select * from products where price not between 10000 and 20000;
```

### IN Operator

Operator **IN** adalah operator untuk mencari kolom dengan beberapa nilai, untuk kebalikannya gunakan `NOT IN`.

```sql
select * from products where category in ('Makanan', 'Minuman');
```

## Order by Clause

Untuk mengurutkan gunakan syntax `ORDER BY`, terdapat dua jenis pengurutan ada Ascending (secara menaik) dengan perintah `ASC` dan Descending (secara menurun) dengan perintah `DESC`. Juga bisa mengurutkan lebih dari satu kolom.

```sql
select * from products order by price asc;

-- lebih dari satu kolom
select * from products order by price asc, id desc;
```

## Limit Clause

Limit dibutuhkan untuk membatasi data, di limit juga bisa melewatkan sejumlah data yang tidak kita ingin lihat. `LIMIT` digunakan untuk paging, dengan kombinasi `OFFSET`.

```sql
select * from products where price > 0 order by price asc, id desc limit 2;
```

Dengan offset, misal untuk page ke-2, kita tentukan `OFFSET`2.

```sql
select * from products where price > 0 order by price asc, id desc limit 2 offset 2;
```

## SELECT DISTINCT

Select distinct digunakan untuk menghilangkan data duplikat.

```sql
select distinct category from products;
```

## Numeric Function

Fitur di dalam PostgreSQL untuk memanipulasi data angka, dibagi menjadi dua, **Arithmetic Operator** dan **Mathematical Function**.

### Arithmetic Operator

| Operator |              Hasil              |
| -------- | :-----------------------------: |
| +        |        Tambah (Addition)        |
| -        |      Kurang (Substraction)      |
| \*       |      Kali (Multiplication)      |
| /        |         Bagi (Division)         |
| %        | Modulus, menghasilkan remainder |

---

```sql
select 10 + 10 as hasil;

select id, name, price / 1000 as price_in_k from products;
```

### Mathematical Function

[PostgreSQL Math Function](https://www.postgresql.org/docs/15/functions-math.html)

```sql
select pi();

select power(10,2);

select cos(10), sin(10), tan(10);

select id, name, power(quantity, 2) as quantity_power_2 from products;
```

## Auto Increment

PostgreSQL memiliki tipe data Number bernama `SERIAL` untuk menambah nilai otomatis (berurut).

```sql
create table admin
(
    id serial not null,
    first_name varchar(100) not null,
    last_name varchar(100),
    primary key (id)
);
```

### Melihat Id / Nilai saat ini

```sql
select currval('admin_id_seq');
```

## Sequence

Sequence adalah fitur dimana kita bisa membuat function auto increment.

```sql
-- Membuat sequence
create sequence contoh_sequence;

-- Memanggil sequence, otomatis increment
select nextval('contoh_sequence');

-- Mengambil nilai terakhir sequence
select currval('contoh_sequence');
```

Melihat Semua Sequence:

```console
\ds
\d admin_id_seq
```

## String Function

[String Functions](https://www.postgresql.org/docs/15/functions-string.html)

```sql
select id, lower(name), length(name), lower(description) from products;
```

## Date & Time Function

[Date & Time Functions](https://www.postgresql.org/docs/15/functions-datetime.html)

```sql
select id, extract(year from created_at), extract(month from created_at) from products;
```

## Flow Control Function

Mirip if else dibahasa pemrograman.
[Flow Control Functions](https://www.postgresql.org/docs/15/functions-conditional.html)

### Menggunakan Case

```sql
select id,
       category,
       case category
            when 'Makanan' then 'Enak'
            when 'Minuman' then 'Seger'
            else 'Apa itu?'
        end as category_case
from products;
```

### Menggunakan Case dengan Operator

```sql
select id,
       price,
       case
           when price <= 15000 then 'Murah'
           when price <= 20000 then 'Mahal'
           else 'Mahal Banget'
           end as "Apakah murah?"
from products;
```

### Menggunakan Check Null

```sql
select id,
       name,
       case
           when description is null then 'Kosong'
           else description
           end as description
from products;
```

## Aggregate Function

[Aggregate Function](https://www.postgresql.org/docs/15/functions-aggregate.html)

```sql
select count(id) from products;

select avg(price) from products;

select max(price) from products;

select min(price) from products;
```

## Group By

`GROUP BY` clouse ini hanya bisa digunakan bersama aggregate function.

```sql
select category, count(id) as "Total Product" from products group by category;

select category,
       avg(price) as "Rata Rata Harga",
       min(price) as "Harga Termurah",
       max(price) as "Harga Termahal"
from products
group by category;
```

## Having Clause

Terkadang ingin melakukan filter terhadap data yang telah digroup, untuk memfilter hasil dari aggregate function harus menggunakan `HAVING` clause.

```sql
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
```

## Constraint

Kita bisa menambahkan constraint untuk menjaga data di tabel tetap baik, Constraint sangat bagus ditambahkan untuk menjaga terjadi validasi yang salah pada program kita, sehingga data yang masuk ke database tetap akan terjaga.

### Unique Constraint

Unique constraint adalah constraint yang memastikan bahwa data kita tetap unique.

```sql
create table customer
(
    id         serial       not null,
    email      varchar(100) not null,
    first_name varchar(100) not null,
    last_name  varchar(100),
    primary key (id),
    constraint unique_email unique (email)
);
```

Operasi mengubah tabel agar menambah/menghapus constraint.

```sql
-- menghapus constraint
alter table customer
drop constraint unique_email;

-- menambah constraint
alter table customer
add constraint unique_email unique (email);
```

### Check Constraint

Membuat tabel dengan check constraint

```sql
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
```

Menambah/Menghapus Check Constraint

```sql
-- menambah check constraint
alter table products add constraint price_check check (price > 1000);

-- menghapus check constraint
```

## Index

Index (btree) digunakan agar memudahkan pencarian data, dan pengurutan menggunakan ORDER BY. Bisa membuat lebih dari satu index di table. Namun untuk proses manipulasi data (insert, update, & delete) akan menjadi lebih lambat.

### Menambah Index

```sql
create index sellers_id_and_name_index on sellers (id,name);
create index sellers_email_and_name_index on sellers (email,name);
```

## Full-Text Search

Full-text search memungkinkan kita mencari sebagian kata di kolom dengan tipe data String. Full-text search menggunakan function to_tsvector(text) dan to_tsquery(query). Operator full-text search menggunakan @@.

### Full-Text Search tanpa Index

```sql
select * from products
where to_tsvector(name) @@ to_tsquery('mie');
```

### Membuat Index Full-Text Search

```sql
-- mengambil bahasa yang tersedia
select cfgname from pg_ts_config;

create index products_name_search on products using gin (to_tsvector('indonesian', name));
create index products_description_search on products using gin (to_tsvector('indonesian', description));

```

### Mencari Menggunakan Full-Text Search

```sql
select * from products where name @@ to_tsquery('mie');
select * from products where description @@ to_tsquery('mie');
```

### Query Operator

`to_tsquery()` mendukung banyak operator. `&` untuk AND, `|` untuk OR `!` untuk NOT, dan `''''` untuk semua data.

```sql
select * from products where name @@ to_tsquery('mie & ayam');
select * from products where name @@ to_tsquery('''ayam bakso''');
```

### Tipe Data TSVECTOR

Kita bisa secara otomatis membuat kolom dengan tipe data `TSVECTOR`. Secara otomatis kolomnya berisi text yang memiliki index Full-Text Search

## Table Relationships

Relasi antar table sering dilakukan di dunia nyata. Biasanya kita akan buat sebuah kolom sebagai referensi ke table lain dimana referensi ini berupa **primary key** di tabel asalnya, ini dinamakan **foreign key**.

### Membuat Table dengan Foreign Key

```sql
create table wishlist
(
    id  serial  not null,
    id_product varchar(10) not null,
    description text,
    primary key (id),
    constraint fk_wishlist_product foreign key (id_product) references products (id)
);
```

### Menambah / Menghapus Foreign Key

```sql
-- Menambah foreign key
alter table wishlist add constraint fk_wishlist_product foreign key (id_product) references products (id);

-- Menghapus foreign key
alter table wishlist drop constraint fk_wishlist_product;
```

| Behavior    | ON DELETE                 | ON UPDATE                 |
| ----------- | ------------------------- | ------------------------- |
| RESTRICT    | Ditolak                   | Ditolak                   |
| CASCADE     | Data akan dihapus         | Data akan ikut diubah     |
| NO ACTION   | Data dibiarkan            | Data akan dibiarkan       |
| SET NULL    | Diubah jadi NULL          | Diubah jadi NULL          |
| SET DEFAULT | Diubah jadi Default Value | Diubah jadi Default Value |

### Mengubah Behavior Menghapus Relasi

```sql
-- contoh ubah behavior
alter table wishlist
add constraint fk_wishlist_product foreign key (id_product) references products (id)
on delete cascade on update cascade;
```

## Join

Join digunakan menseleksi beberapa tabel sekaligus, tetapi perlu menentukan tabel yang mana yang merupakan referensi ke tabel lain (cocok dengan foreign key). Namun `JOIN` ini idealnya **tidak lebih dari 5 tabel** karena mengakibatkan performa menjadi berat dan lambat.

### JOIN Semua Field

```sql
SELECT * from wishlist join products on wishlist.id_product = products.id;
```

### JOIN beberapa field

```sql
SELECT products.id, products.name, wishlist.description from wishlist join products on wishlist.id_product = products.id;

-- memakai alias (AS)
SELECT p.id, p.name, w.description from wishlist as w join products as p on w.id_product = p.id;
```

### JOIN Multiple Table

```sql
select c.email, p.id, p.name, w.description
from wishlist as w
join products as p on w.id_product = p.id
join customer as c on c.id = w.id_customer;
```

## Jenis Relasi Tabel

### One to One Relationship

One to one artinya sebuah table hanya boleh berelasi ke maksimal 1 data di tabel lain. Misal toko online customer hanya boleh punya 1 wallet.

![Contoh](/img/contoh-one-to-one.png)

### Membuat Table Wallet (dengan unique)

```sql
create table wallet
(
    id          serial not null,
    id_customer int not null,
    balance     int not null default 0,
    primary key (id),
    constraint wallet_customer_unique unique (id_customer),
    constraint fk_wallet_customer foreign key (id_customer) references customer (id)
);
```

### One to Many Relationship

One to many artinya satu data bisa digunakan lebih dari satu kali di tabel relasinya. One to many tidak ada batasan berapa banyak data digunakan, contohnya relasi tabel categories dan products, dimana satu category bisa digunakan oleh lebih dari satu product.

![Contoh](/img/one-to-many.png)

### Contoh Implementasi One To Many

```sql
-- membuat table category
create table categories(
    id  varchar(10) not null,
    name varchar(100) not null,
    primary key (id)
);

-- edit table products and make constraint fk
alter table products
add constraint fk_product_category foreign key (id_category) references categories(id);

-- select join one to many relationship
select * from products join categories on products.id_category = categories.id;
```

### Many to Many Relationship

Many to many adalah relasi dimana ada relasi antara 2 tabel, dimana tabel pertama bisa punyai banyak relasi di tabel kedua, dan tabel kedua pun punya banyak relasi di tabel pertama. Contoh relasi antara produk dan penjualan, setiap produk bisa dijual berkali kali, dan setiap penjualan bisa untuk lebih dari satu produk.

Many to many membutuhkan tabel relasi yang bertugas sebagai jembatan untuk menggabungkan relasi many to many, isi table ini ada id dari tabel pertama dan id tabel kedua. Contoh kasusnya berarti id_product dan id_order.

![Contoh](/img/many-to-many.png)

#### Membuat Tabel Order

```sql
create table orders
(
    id          serial      not null,
    total       int         not null,
    order_date  timestamp   not null default current_timestamp,
    primary key (id)
);

```

#### Membuat Tabel Order Detail

```sql
create table orders_detail
(
    id_product  varchar(10) not null,
    id_order    int         not null,
    price       int         not null,
    quantity    int         not null,
    primary key (id_product, id_order)
);
```

#### Membuat Foreign Key

```sql
alter table orders_detail
add constraint fk_orders_detail_product foreign key (id_product) references products (id);

alter table orders_detail
add constraint fk_orders_detail_order foreign key (id_order) references orders (id);
```

## Jenis Join

Join ada banyak jenis-jenisnya di PostgreSQL antara lain:

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL JOIN

### Inner Join

![Contoh](/img/img_inner_join.png)

Inner join hanya menampilkan data yang memiliki relasi di tabel lainnya, jika tidak memiliki relasi maka tidak akan ditampilkan. Inner join ini dipakai secara default di PostgreSQL ketika kita menulis `join` di sql.

```sql
select * from categories
inner join products on products.id_category = categories.id;
```

### Left Join

![Contoh](/img/img_left_join.png)

Left join mirip seperti inner join, hanya saja semua data di tabel pertama akan diambil, jika ada yang tak memiliki relasi di tabel kedua, maka hasilnya `NULL`.

```sql
select * from categories
left join products on products.id_category = categories.id;
```

### Right Join

![Contoh](/img/img_right_join.png)

Right join mirip seperti inner join, hanya saja semua data di tabel kedua akan diambil, jika ada yang tak memiliki relasi di tabel pertama, maka hasilnya `NULL`.

```sql
select * from categories
right join products on products.id_category = categories.id;
```

### Full Join

![Contoh](/img/img_full_outer_join.png)

Full join adalah join dimana semua data di tabel pertama dan kedua akan ditampilkan, jika tidak ada join maka hasilnya akan berisi data null.

```sql
select * from categories
full join products on products.id_category = categories.id;
```

## Subqueries

### Subquery di WHERE

Subquery di WHERE
PostgreSQL mendukung pencarian data menggunakan WHERE dari hasil SELECT query, fitur ini dinamakan subquery. Contoh ketika kita ingin mencari products yang harganya diatas rata-rata, artinya melakukan `SELECT` denagn `WHERE price > harga rata`, dimana harga rata-rata perlu kita hitung menggunakan **query SELECT** lainnya menggunakan **aggregate function** `AVG`.

```sql
select * from products where price > (select avg(price) from products);
```

### Subquery di FROM

Subquery bisa dilakukan di `FROM` clause, Misal ingin mencari data dari hasil query `SELECT` juga bisa dilakukan di PostgreSQL.

```sql
select max(price)
from (select products.price as price
from categories join products on products.id_category = categories.id) as contoh;
```

## Set Operator

PostgreSQL mendukung operator set, yaitu operasi antara hasil dua `SELECT` query. Antara lain:

- UNION
- UNION ALL
- INTERSECT
- EXCEPT

### UNION

Union adalah operasi menggabungkan dua buah `SELECT` query, dimana jika terdapat data yang duplikat, data duplikatnya dihapus dari hasil query.

```sql
select distinct email from customer
union select distinct email from guestbooks;
```

### UNION ALL

Union all adalah operasi yang sama dengan `UNION`, namun data duplikat tetap akan ditampilkan di hasil querynya.

```sql
select distinct email from customer
union all select distinct email from guestbooks;

-- dikombinasikan dengan subquery
select email, count(email)
from (select email from customer union all
select email from guestbooks) as contoh
group by email;
```

### INTERSECT

Intersect adalah operasi menggabungkan dua query, namun yang diambil hanya data yang terdapat pada hasil query pertama dan kedua (irisan). Data yang tidak hanya ada di salah satu query, akan dihapus di hasil operasi `INTERSECT`. Datanya muncul tidak dalam keadaan duplikat.

```sql
select distinct email from customer
intersect
select distinct email from guestbooks;
```

### EXCEPT

Except adalah operasi dimana query pertama akan dihilangkan oleh query kedua, artinya jika ada data di query pertama yang sama dengan data yang ada di query kedua, maka data tersebut akan dihpuas dari hasil query `EXCEPT`.

```sql
select distinct email from customer
except
select distinct email from guestbooks;
```

## Database Transaction

Database Transaction adalah fitur di DBMS dimana kita bisa melakukan beberapa perintah dan dianggap menjadi sebuah kesatuan perintah yang disebut _transaction_. Jika satu proses gagal, maka perintah perintah yang lain akan dibatalkan, dan jika sukses, maka semua perintah akan dipastikan sukses.

Transaction di PostgreSQL

| Perintah          | Keterangan                                                                                                    |
| ----------------- | ------------------------------------------------------------------------------------------------------------- |
| START TRANSACTION | Memulai proses transaksi, proses selanjutnya akan dianggap transaksi sampai perintah `COMMIT` atau `ROLLBACK` |
| COMMIT            | Menyimpan secara permanen seluruh proses transaksi                                                            |
| ROLLBACK          | Membatalkan secara permanen seluruh proses transaksi                                                          |

> [!WARNING]
> Perintah DDL (Data Definition Language) tidak bisa menggunakan fitur transaction, DDL adalah perintah-perintah yang digunakan untuk merubah struktur, seperti membuat tabel, menambah kolom, menghapus tabel, menghapus database dan sejenisnya. Transaction hanya bisa dilakukan pada perintah DML (Data Manipulation Language), seperti Operasi `INSERT`, `UPDATE`, dan `DELETE`.

```sql
-- commit
start transaction ;

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction');

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 2');

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 3');

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 4');

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 5');

commit;

-- rollback
start transaction ;

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback');

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback 2');

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback 3');

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback 4');

insert into guestbooks (email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback 5');

rollback;
```

## Locking

Locking adalah proses mengunci data di DBMS. Proses mengunci data sangat penting, salah satunya agar data benar benar terjamin konsistensinya. Karena pada kenyataannya, aplikasi yang akan dibuat pasti digunakan oleh banyak pengguna, dan banyak pengguna bisa saja akan mengakses data yang sama, jika tidak ada proses locking, bisa dipastikan akan terjadi **RACE CONDITION**, yaitu proses balapan ketika mengubah data yang sama.

Contoh ketika belanja di toko online, kita akan balapan membeli barang yang sama, jika data tidak terjaga, bisa jadi kita salah update stock karena pada saat yang bersamaan banyak yang melakukan perubahan stock barang.

### Locking Record

Saat kita melakukan proses `TRANSACTION`, lalu kita melakukan proses perubahan data, data yang kita ubah tersebut akan secara otomatis di LOCK. Hal ini membuat proses **TRANSACTION** menjadi sangat aman. Oleh karena itu, sangat disarankan untuk selalu menggunakan fitur `TRANSACTION` ketika memanipulasi data di database, terutama ketika perintah manipulasinya lebih dari satu kali. Locking membuat sebuah proses perubahan yang dilakukan oleh pihak lain akan diminta untuk menunggu. Data akan dilocak sampai kita melakukan commit atau rollback transaksi tersebut.

```sql
-- di client X
start transaction ;

update products
set description = 'Mie ayam original enak'
where id = 'P0001';

select * from products where id = 'P0001';

commit;

-- di client Y (akan menunggu prosesnya sebelum melakukan commit atau rollback)
update products set quantity = 200 where id = 'P0001';

```

### Locking Record Manual

Selain secara otomatis, kadang saat kita membuat aplikasi, kita juga sering melakukan `SELECT` query terlebih dahulu sebelum melakukan proses `UPDATE` misalnya. Cara locking sebuah data secara manual, kita bisa tambahkan perintah `FOR UPDATE` di belakang query `SELECT`. Saat kita lock record yang kita select, maka jika ada proses lain akan melakukan `UPDATE, DELETE, SELECT FOR UPDATE` lagi maka proses lain diminta menunggu sampai kita selesai `COMMIT` atau `ROLLBACK` transaction.

```sql
-- di client X
start transaction ;

select * from products where id = 'P0001' for update;

rollback;

-- di client Y (Menunggu proses client X commit atau rollback)
update products set price = 30000 where id = 'P0001';
```

### Deadlock

Deadlock adalah situasi 2 proses yang saling menuggu satu sama lain, namun data yang ditunggu dua-duanya dilock oleh proses lainnya, sehingga proses menunggu ini tidak akan pernah selesai.

Contoh

- Proses 1 melakukan SELECT FOR UPDATE untuk data 001
- Proses 2 melakukan SELECT FOR UPDATE untuk data 002
- Proses 1 melakukan SELECT FOR UPDATE untuk data 002, diminta menunggu karena dilock oleh proses 2
- Proses 2 melakukan SELECT FOR UPDATE untuk data 001, diminta menunggu karena dilock oleh proses 1
- Akhirnya proses 1 dan proses 2 saling menuggu
- Deadlock terjadi

```sql
start transaction ; -- di client 1 & client 2

select * from products where id = 'P0001' for update;  -- di client 1

select * from products where id = 'P0002' for update;  -- di client 2

select * from products where id = 'P0002' for update;  -- di client 1

-- anggap proses ini dilakukan secara bersamaan, sebelum rollback atau commit. Maka akan terjadi Deadlock, namun PostgreSQL akan mendeteksi Deadlock dan menghentikan salah satu proses
select * from products where id = 'P0001' for update; -- di client 2 (dibatalkan)

rollback; -- di client 1 & 2
```

Deadlock error:
![Deadlock Error dan Locking dilepas](/img/deadlock%20error.png)

## Schema

Di awal kita ibaratkan bahwa database adalah sebuah folder, dan tabel adalah file-filenya. Di PostgreSQL terdapat fitur bernama **Schema**. Anggap saja folder di dalam database, sebenarnya ketika membuat database, secara tidak sadar kita menyimpan semua tabel kita di _schema public_. Kita bisa membuat schema lain, dan pada schema yang berbeda, kita bisa membuat tabel dengan nama yang sama.

Ketika membuat database, secara otomatis terdapat schema bernama public, dan ketika membuat table, secara otomatis kita akan membuat table tersebut berada di **schema public**.

### Melihat Schema Saat Ini

```sql
select current_schema();

-- or

show search_path;
```

### Membuat dan Menghapus Schema

```sql
-- membuat
create schema contoh;

-- menghapus
drop schema contoh;
```

### Pindah Schema

```sql
set search_path to contoh;

show search_path;

select current_schema();
```

### Membuat Table di Schema

Satt kita membuat table, secara otomatis PostgreSQL akan membuat table di schema yang sedang kita pilih, jika kita ingin menentukan schema secara manual tanpa menggunakan schema yang sedang dipilih, kita bisa menambahkan prefix nama schema di awal nama tablenya.

Misal namaschema namatable

Termasuk jika ingin melakukan operasi DML ke table, bisa gunakan prefix namaschema.

```sql
-- membuat tabel di schema contoh
create table contoh.products
(
    id serial not null,
    name varchar(100) not null,
    primary key (id)
);

-- memasukkan data tabel di schema contoh
insert into contoh.products(name)
values ('iPhone'),
('Play Station');

-- seleksi tabel di schema contoh
select * from contoh.products;
```

## User Management

### Root User

Secara default, PostgreSQL membuat user utama sebagai super administrator, namun **best practicenya** saat menjalankan PostgreSQL dengan aplikasi yang kita buat, sangat disarankan tidak menggunakan user utama. Lebih baik buat user khusus untuk tiap aplikasi, bahkan bisa batasi dengan hak akses user.

Misalnya hanya bisa `SELECT`, dan tidak boleh melakukan `INSERT`, `UPDATE` atau `DELETE`.

### Membuat / Menghapus User

```sql
-- membuat
create role nama;
create role bagus;

-- menghapus
drop role nama;
drop role bagus;
```

### Menambah / Mengubah Option Role Ke User

PostgreSQL Documentation Role:

- [Create Role Docs.](https://www.postgresql.org/docs/15/sql-createrole.html)
- [Alter Role Docs.](https://www.postgresql.org/docs/15/sql-alterrole.html)

```sql
create role budi login password 'rahasia';

alter role bagus login password 'rahasia';

-- Melihat role
SELECT rolname FROM pg_roles;
```

### Daftar atau Hapus Hak Akses

Dokumentasi Hak Akses:

- [GRANT (Daftar Hak Akses)](https://www.postgresql.org/docs/15/sql-grant.html)
- [REVOKE (Hapus Hak Akses)](https://www.postgresql.org/docs/15/sql-revoke.html)

```sql
grant insert, update, select on all tables in schema public to bagus;
grant insert, update, select on customer to budi;

-- grant sequence
grant usage, select, update on guestbooks_id_seq to bagus;

revoke insert, update, select on customer from budi;
```

## Backup Database

Saat membuat aplikasi menggunakan database, ada baiknya kita selalu melakukan backup data secara reguler, Untungnya PostgreSQL mendukung proses backup database. Untuk melakukan backup, kita tidak menggunakan perintah SQL, melainkan PostgreSQL menyediakan sebuah aplikasi khusus untuk backup db, namanya `pg_dump` <https://www.postgresql.org/docs/15/app-pgdump.html>.

```sql
pg_dump --host=localhost --port=5432 --dbname=belajar --username=user --format=plain --file=/Users/bagus/backup.sql
```

## Restore Database

Selain backup, PostgreSQL mendukung kita untuk bisa melakukan proses restore data dari file hasil backup. untuk restore bisa menggunakan aplikasi `psql`.

```sql
psql --host=localhost --port=5432 --dbname=belajar_restore --username=user --file=Downloads/backup.sql
```

## Referensi

- YouTube Programmer Zaman Now
- w3schools.com (Gambar Join)
