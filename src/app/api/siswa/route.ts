import { PrismaClient } from "@prisma/client";
import { NextResponse } from "next/server";

const prisma = new PrismaClient();

export async function GET() {
  try {
    const siswa = await prisma.siswa.findMany({});
    return NextResponse.json(siswa, { status: 201, statusText: "Success" });
  } catch (error) {
    return NextResponse.json({ error });
  }
}

export async function POST(req: Request) {
  try {
    const body = await req.json();
    const {nis, nama, jenisKelamin, kontakOrtu } = body;

    if (!nis || !nama || !jenisKelamin || !kontakOrtu ) {
      return NextResponse.json({
        error: "Harus mengisi semua input",
        status: 500,
      }); 
    }

    const siswa = await prisma.siswa.create({
      data: {
        nama,
        jenisKelamin,
        kontakOrtu
      },
    });

    return NextResponse.json({
      message: "Data berhasil ditambahkan",
      id: siswa.nis,
    });
  } catch (error) {
    return NextResponse.json({ error });
  }
}