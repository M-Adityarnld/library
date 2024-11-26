/*
  Warnings:

  - You are about to drop the column `kelas` on the `Siswa` table. All the data in the column will be lost.
  - Added the required column `link_gambar` to the `Buku` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status` to the `Buku` table without a default value. This is not possible if the table is not empty.
  - Added the required column `genre` to the `Buku` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `keterangan` on the `Buku` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `jumlah` to the `Denda` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `ket` on the `Denda` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `status` on the `Denda` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `status` on the `FormBukti` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `jenisKelamin` on the `Guru` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `idKelas` to the `Siswa` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `jenisKelamin` on the `Siswa` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "jk" AS ENUM ('Laki_Laki', 'Perempuan');

-- CreateEnum
CREATE TYPE "Genre" AS ENUM ('FANTASY', 'SCIFI', 'MYSTERY', 'BIOGRAPHY', 'HISTORY', 'ROMANCE', 'OTHER');

-- CreateEnum
CREATE TYPE "stat_buku" AS ENUM ('Tersedia', 'Habis');

-- CreateEnum
CREATE TYPE "ket_buku" AS ENUM ('Sumbangan', 'Denda');

-- CreateEnum
CREATE TYPE "stat_denda" AS ENUM ('Dibayar', 'Belum_Dibayar');

-- CreateEnum
CREATE TYPE "ket_denda" AS ENUM ('Terlambat', 'Hilang', 'Rusak');

-- CreateEnum
CREATE TYPE "stat_bukti" AS ENUM ('Disetujui', 'Tidak_Disetujui');

-- CreateEnum
CREATE TYPE "Jumlah" AS ENUM ('Rp500', 'Rp110000', 'Dua_Buku');

-- AlterTable
ALTER TABLE "Buku" ADD COLUMN     "link_gambar" TEXT NOT NULL,
ADD COLUMN     "status" "stat_buku" NOT NULL,
DROP COLUMN "genre",
ADD COLUMN     "genre" "Genre" NOT NULL,
DROP COLUMN "keterangan",
ADD COLUMN     "keterangan" "ket_buku" NOT NULL;

-- AlterTable
ALTER TABLE "Denda" ADD COLUMN     "jumlah" "Jumlah" NOT NULL,
DROP COLUMN "ket",
ADD COLUMN     "ket" "ket_denda" NOT NULL,
DROP COLUMN "status",
ADD COLUMN     "status" "stat_denda" NOT NULL;

-- AlterTable
ALTER TABLE "FormBukti" DROP COLUMN "status",
ADD COLUMN     "status" "stat_bukti" NOT NULL;

-- AlterTable
ALTER TABLE "Guru" DROP COLUMN "jenisKelamin",
ADD COLUMN     "jenisKelamin" "jk" NOT NULL;

-- AlterTable
ALTER TABLE "Siswa" DROP COLUMN "kelas",
ADD COLUMN     "idKelas" TEXT NOT NULL,
DROP COLUMN "jenisKelamin",
ADD COLUMN     "jenisKelamin" "jk" NOT NULL;

-- CreateTable
CREATE TABLE "Kelas" (
    "id" TEXT NOT NULL,
    "nama" TEXT NOT NULL,

    CONSTRAINT "Kelas_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Siswa" ADD CONSTRAINT "Siswa_idKelas_fkey" FOREIGN KEY ("idKelas") REFERENCES "Kelas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
