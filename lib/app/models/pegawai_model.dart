// To parse this JSON data, do
//
//     final pegawaiModel = pegawaiModelFromJson(jsonString);

import 'dart:convert';

PegawaiModel pegawaiModelFromJson(String str) =>
    PegawaiModel.fromJson(json.decode(str));

String pegawaiModelToJson(PegawaiModel data) => json.encode(data.toJson());

class PegawaiModel {
  PegawaiModel({
    required this.emailPegawai,
    required this.foto,
    required this.telepon,
    required this.hak,
    required this.namaPegawai,
    required this.pin,
  });

  String emailPegawai;
  String foto;
  String telepon;
  String hak;
  String namaPegawai;
  String pin;

  factory PegawaiModel.fromJson(Map<String, dynamic> json) => PegawaiModel(
        emailPegawai: json["email_pegawai"],
        foto: json["foto"],
        telepon: json["telepon"],
        hak: json["hak"],
        namaPegawai: json["nama_pegawai"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "email_pegawai": emailPegawai,
        "foto": foto,
        "telepon": telepon,
        "hak": hak,
        "nama_pegawai": namaPegawai,
        "pin": pin,
      };
}
