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

```console
select datname from pg_database;
```

## Membuat Database Baru

`nama_database` diisi dengan nama database yang diinginkan

```console
create database nama_database;
```

## Menghapus Database

`nama_database` diisi dengan nama database yang diinginkan

```console
drop database nama_database;
```

## Menggunakan Database

```console
\c namadatabase
```

## Referensi

-   YouTube Programmer Zaman Now
