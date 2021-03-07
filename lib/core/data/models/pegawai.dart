// To parse this JSON data, do
//
//     final pegawai = pegawaiFromJson(jsonString);

import 'dart:convert';

List<Pegawai> pegawaiFromJson(String str) => List<Pegawai>.from(json.decode(str).map((x) => Pegawai.fromJson(x)));

String pegawaiToJson(List<Pegawai> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pegawai {
    Pegawai({
        this.idPegawai,
        this.nama,
        this.alamat,
        this.email,
        this.phone,
        this.divisi,
        this.jabatan,
        this.gender,
    });

    int idPegawai;
    String nama;
    String alamat;
    String email;
    String phone;
    String divisi;
    String jabatan;
    String gender;

    factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        idPegawai: json["idPegawai"],
        nama: json["nama"],
        alamat: json["alamat"],
        email: json["email"],
        phone: json["phone"].toString(),
        divisi: json["divisi"],
        jabatan: json["jabatan"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "idPegawai": idPegawai,
        "nama": nama,
        "alamat": alamat,
        "email": email,
        "phone": phone,
        "divisi": divisi,
        "jabatan": jabatan,
        "gender": gender,
    };
}
