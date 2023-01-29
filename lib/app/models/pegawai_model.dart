// To parse this JSON data, do
//
//     final pegawaiModel = pegawaiModelFromJson(jsonString);

import 'dart:convert';

PegawaiModel pegawaiModelFromJson(String str) => PegawaiModel.fromJson(json.decode(str));

String pegawaiModelToJson(PegawaiModel data) => json.encode(data.toJson());

class PegawaiModel {
    PegawaiModel({
        required this.emailPegawai,
        required this.foto,
        required this.telepon,
        required this.namaPegawai,
        required this.jabatan,
        required this.pin,
    });

    String emailPegawai;
    String foto;
    String telepon;
    String namaPegawai;
    String jabatan;
    String pin;

    factory PegawaiModel.fromJson(Map<String, dynamic> json) => PegawaiModel(
        emailPegawai: json["email_pegawai"],
        foto: json["foto"],
        telepon: json["telepon"],
        namaPegawai: json["nama_pegawai"],
        jabatan: json["jabatan"],
        pin: json["pin"],
    );

    Map<String, dynamic> toJson() => {
        "email_pegawai": emailPegawai,
        "foto": foto,
        "telepon": telepon,
        "nama_pegawai": namaPegawai,
        "jabatan": jabatan,
        "pin": pin,
    };
}
