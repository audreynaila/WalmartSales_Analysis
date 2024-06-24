# Analisis Data Penjualan Walmart

## Tentang

Proyek ini bertujuan untuk mengeksplorasi data penjualan Walmart guna memahami cabang dan produk yang berkinerja terbaik, tren penjualan berbagai produk, serta perilaku pelanggan. Tujuannya adalah untuk mempelajari bagaimana strategi penjualan dapat ditingkatkan dan dioptimalkan. Dataset diperoleh dari [Kompetisi Walmart Sales Forecasting di Kaggle](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

"Dalam kompetisi ini, pencari kerja diberikan data penjualan historis dari 45 toko Walmart yang berlokasi di berbagai daerah. Setiap toko memiliki banyak departemen, dan peserta harus memproyeksikan penjualan untuk setiap departemen di setiap toko. Untuk menambah tantangan, acara markdown liburan terpilih disertakan dalam dataset. Markdown ini diketahui mempengaruhi penjualan, tetapi sulit untuk memprediksi departemen mana yang terpengaruh dan sejauh mana dampaknya."

## Tujuan Proyek

Tujuan utama proyek ini adalah untuk mendapatkan wawasan tentang data penjualan Walmart guna memahami berbagai faktor yang mempengaruhi penjualan di berbagai cabang.

## Tentang Data

Dataset diperoleh dari [Kompetisi Walmart Sales Forecasting di Kaggle](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting). Dataset ini berisi transaksi penjualan dari tiga cabang Walmart yang berlokasi di Mandalay, Yangon, dan Naypyitaw. Data ini memiliki 17 kolom dan 1000 baris:

| Kolom          | Deskripsi                                    | Tipe Data    |
|----------------|----------------------------------------------|--------------|
| invoice_id     | ID faktur dari penjualan                     | VARCHAR(30)  |
| branch         | Cabang tempat penjualan dilakukan            | VARCHAR(5)   |
| city           | Lokasi cabang                                | VARCHAR(30)  |
| customer_type  | Jenis pelanggan                              | VARCHAR(30)  |
| gender         | Jenis kelamin pelanggan                      | VARCHAR(10)  |
| product_line   | Lini produk yang dijual                      | VARCHAR(100) |
| unit_price     | Harga per unit produk                        | DECIMAL(10,2)|
| quantity       | Jumlah produk yang dijual                    | INT          |
| tax_pct        | Persentase pajak                             | FLOAT(6,4)   |
| total          | Total harga setelah pajak                    | DECIMAL(12,4)|
| date           | Tanggal penjualan                            | DATETIME     |
| time           | Waktu penjualan                              | TIME         |
| payment        | Metode pembayaran                            | VARCHAR(15)  |
| cogs           | Biaya penjualan                              | DECIMAL(10,2)|
| gross_margin_pct| Persentase margin kotor                      | FLOAT(11,9)  |
| gross_income   | Pendapatan kotor                             | DECIMAL(12,4)|
| rating         | Rating dari pelanggan                        | FLOAT(2,1)   |

## Daftar Analisis

### Analisis Produk

Menganalisis data untuk memahami berbagai lini produk, kinerja terbaik dari lini produk, dan lini produk yang perlu ditingkatkan.

### Analisis Penjualan

Analisis ini bertujuan untuk menjawab pertanyaan tentang tren penjualan produk. Hasilnya dapat membantu mengukur efektivitas setiap strategi penjualan yang diterapkan dan modifikasi yang diperlukan untuk meningkatkan penjualan.

### Analisis Pelanggan

Analisis ini bertujuan untuk mengungkap segmen pelanggan yang berbeda, tren pembelian, dan profitabilitas dari setiap segmen pelanggan.

## Pendekatan yang Digunakan

### Data Wrangling

Langkah pertama di mana inspeksi data dilakukan untuk memastikan nilai NULL dan nilai yang hilang terdeteksi dan metode penggantian data digunakan untuk menggantikan nilai yang hilang atau NULL.
- Membangun database
- Membuat tabel dan memasukkan data.
- Memilih kolom dengan nilai null. Tidak ada nilai null dalam database karena saat membuat tabel, kita menetapkan NOT NULL untuk setiap bidang, sehingga nilai null difilter.
  
### Feature Engineering

Membantu menghasilkan beberapa kolom baru dari yang sudah ada.
- Menambahkan kolom baru bernama `time_of_day` untuk memberikan wawasan penjualan di Pagi, Siang, dan Malam.
- Menambahkan kolom baru bernama `day_name` yang berisi hari-hari dalam minggu ketika transaksi dilakukan.
- Menambahkan kolom baru bernama `month_name` yang berisi bulan-bulan dalam tahun ketika transaksi dilakukan.

### Analisis Data Eksploratif (EDA)

Analisis data eksploratif dilakukan untuk menjawab pertanyaan yang terdaftar dan tujuan dari proyek ini.

## Kesimpulan

### Pertanyaan Bisnis yang Dijawab

#### Pertanyaan Umum

1. Berapa banyak kota unik yang ada dalam data?
2. Di kota mana setiap cabang berada?

#### Produk

1. Berapa banyak lini produk unik yang ada dalam data?
2. Metode pembayaran apa yang paling umum?
3. Lini produk apa yang paling banyak dijual?
4. Berapa total pendapatan per bulan?
5. Bulan apa yang memiliki COGS terbesar?
6. Lini produk apa yang memiliki pendapatan terbesar?
7. Kota mana yang memiliki pendapatan terbesar?
8. Lini produk apa yang memiliki VAT terbesar?
9. Menampilkan setiap lini produk dan menambahkan kolom yang menunjukkan "Good", "Bad". Baik jika lebih besar dari penjualan rata-rata.
10. Cabang mana yang menjual lebih banyak produk dari rata-rata?
11. Lini produk apa yang paling umum berdasarkan jenis kelamin?
12. Berapa rata-rata rating setiap lini produk?

#### Penjualan

1. Jumlah penjualan yang dilakukan setiap waktu dalam sehari per hari kerja.
2. Tipe pelanggan mana yang membawa pendapatan terbesar?
3. Kota mana yang memiliki persentase pajak/VAT (Value Added Tax) terbesar?
4. Tipe pelanggan mana yang membayar pajak terbesar?

#### Pelanggan

1. Berapa banyak tipe pelanggan unik yang ada dalam data?
2. Berapa banyak metode pembayaran unik yang ada dalam data?
3. Tipe pelanggan apa yang paling umum?
4. Tipe pelanggan mana yang paling banyak membeli?
5. Apa jenis kelamin sebagian besar pelanggan?
6. Apa distribusi jenis kelamin per cabang?
7. Waktu mana dalam sehari yang memberikan rating tertinggi?
8. Waktu mana dalam sehari yang memberikan rating tertinggi per cabang?
9. Hari mana dalam seminggu yang memiliki rating rata-rata terbaik?
10. Hari mana dalam seminggu yang memiliki rating rata-rata terbaik per cabang?


