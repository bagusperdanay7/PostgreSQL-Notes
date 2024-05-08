# PostgreSQL (Programmer Zaman Now)

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

## Referensi

-   YouTube Programmer Zaman Now
