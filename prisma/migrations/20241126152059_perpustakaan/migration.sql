-- Active: 1732635000928@@127.0.0.1@5432@perpustakaan
-- CreateTable
CREATE TABLE "Buku" (
    "isbn" TEXT NOT NULL,
    "judul" TEXT NOT NULL,
    "penulis" TEXT NOT NULL,
    "tahunTerbit" INTEGER NOT NULL,
    "penerbit" TEXT,
    "hal" TEXT NOT NULL,
    "genre" TEXT,
    "sinopsis" TEXT,
    "stok" INTEGER NOT NULL,
    "keterangan" TEXT NOT NULL,


CONSTRAINT "Buku_pkey" PRIMARY KEY ("isbn") );

-- CreateTable
CREATE TABLE "Denda" (
    "peminjamanIdPeminjaman" TEXT NOT NULL,
    "peminjamanIsbn" TEXT NOT NULL,
    "peminjamanNis" TEXT NOT NULL,
    "peminjamanNip" TEXT NOT NULL,
    "ket" TEXT NOT NULL,
    "status" TEXT NOT NULL,


    CONSTRAINT "Denda_pkey" PRIMARY KEY ("peminjamanIdPeminjaman","peminjamanIsbn","peminjamanNis","peminjamanNip")
);

-- CreateTable
CREATE TABLE "FormBukti" (
    "idBukti" TEXT NOT NULL,
    "siswaNis" TEXT NOT NULL,
    "bukuIsbn" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "intisari" TEXT NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "halBuku" TEXT NOT NULL,


CONSTRAINT "FormBukti_pkey" PRIMARY KEY ("idBukti") );

-- CreateTable
CREATE TABLE "Guru" (
    "nip" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "jenisKelamin" TEXT NOT NULL,
    "kontak" TEXT NOT NULL,
    "alamat" TEXT NOT NULL,


CONSTRAINT "Guru_pkey" PRIMARY KEY ("nip") );

-- CreateTable
CREATE TABLE "LaporanPerpus" (
    "idLaporan" TEXT NOT NULL,
    "idPeminjaman" TEXT NOT NULL,
    "idPetugas" TEXT NOT NULL,
    "isbn" TEXT NOT NULL,
    "nis" TEXT NOT NULL,
    "nip" TEXT NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,


    CONSTRAINT "LaporanPerpus_pkey" PRIMARY KEY ("idLaporan","isbn","idPeminjaman","nis","nip")
);

-- CreateTable
CREATE TABLE "Peminjaman" (
    "idPeminjaman" TEXT NOT NULL,
    "bukuIsbn" TEXT NOT NULL,
    "siswaNis" TEXT NOT NULL,
    "guruNip" TEXT NOT NULL,
    "tanggalPinjam" TIMESTAMP(3) NOT NULL,
    "tanggalPengembalian" TIMESTAMP(3) NOT NULL,
    "keterangan" TEXT NOT NULL,


    CONSTRAINT "Peminjaman_pkey" PRIMARY KEY ("bukuIsbn","idPeminjaman","siswaNis","guruNip")
);

-- CreateTable
CREATE TABLE "PetugasPerpus" (
    "idPetugas" TEXT NOT NULL,
    "nama" TEXT NOT NULL,


CONSTRAINT "PetugasPerpus_pkey" PRIMARY KEY ("idPetugas") );

-- CreateTable
CREATE TABLE "Siswa" (
    "nis" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "jenisKelamin" TEXT NOT NULL,
    "kelas" TEXT NOT NULL,
    "kontakOrtu" TEXT NOT NULL,


CONSTRAINT "Siswa_pkey" PRIMARY KEY ("nis") );

-- AddForeignKey
ALTER TABLE "Denda"
ADD CONSTRAINT "Denda_peminjamanIdPeminjaman_peminjamanIsbn_peminjamanNis__fkey" FOREIGN KEY (
    "peminjamanIdPeminjaman",
    "peminjamanIsbn",
    "peminjamanNis",
    "peminjamanNip"
) REFERENCES "Peminjaman" (
    "idPeminjaman",
    "bukuIsbn",
    "siswaNis",
    "guruNip"
) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FormBukti"
ADD CONSTRAINT "FormBukti_bukuIsbn_fkey" FOREIGN KEY ("bukuIsbn") REFERENCES "Buku" ("isbn") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FormBukti"
ADD CONSTRAINT "FormBukti_siswaNis_fkey" FOREIGN KEY ("siswaNis") REFERENCES "Siswa" ("nis") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LaporanPerpus"
ADD CONSTRAINT "LaporanPerpus_isbn_idPeminjaman_nis_nip_fkey" FOREIGN KEY (
    "isbn",
    "idPeminjaman",
    "nis",
    "nip"
) REFERENCES "Peminjaman" (
    "bukuIsbn",
    "idPeminjaman",
    "siswaNis",
    "guruNip"
) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LaporanPerpus"
ADD CONSTRAINT "LaporanPerpus_idPetugas_fkey" FOREIGN KEY ("idPetugas") REFERENCES "PetugasPerpus" ("idPetugas") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Peminjaman"
ADD CONSTRAINT "Peminjaman_bukuIsbn_fkey" FOREIGN KEY ("bukuIsbn") REFERENCES "Buku" ("isbn") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Peminjaman"
ADD CONSTRAINT "Peminjaman_siswaNis_fkey" FOREIGN KEY ("siswaNis") REFERENCES "Siswa" ("nis") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Peminjaman"
ADD CONSTRAINT "Peminjaman_guruNip_fkey" FOREIGN KEY ("guruNip") REFERENCES "Guru" ("nip") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Buku"
DROP COLUMN "tahunTerbit",
ADD COLUMN "tahun_terbit" INTEGER NOT NULL;