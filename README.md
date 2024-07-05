# PostgreSQL Notes (from Programmer Zaman Now)

---

Ini merupakan catatan pribadi mengenai materi dari **PostgreSQL** Database dengan Pak Eko.

## Mengunakan PostgreSQL Pertama kali

Masukkan syntax berikut di terminal, sesuaikan `--username` dan `--password` nya.

```console
psql --host=localhost --port=5432 --username=postgres --password
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

### Melihat Semua data dan hanya beberapa kolom.

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

## Referensi

- YouTube Programmer Zaman Now
