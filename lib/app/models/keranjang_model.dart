// To parse this JSON data, do
//
//     final keranjangModel = keranjangModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KeranjangModel keranjangModelFromJson(String str) => KeranjangModel.fromJson(json.decode(str));

String keranjangModelToJson(KeranjangModel data) => json.encode(data.toJson());

class KeranjangModel {
    KeranjangModel({
        required this.diskon,
        required this.namaDiskon,
        required this.total,
        required this.emailPegawai,
    });

    int diskon;
    String namaDiskon;
    int total;
    String emailPegawai;

    factory KeranjangModel.fromJson(Map<String, dynamic> json) => KeranjangModel(
        diskon: json["diskon"],
        namaDiskon: json["nama_diskon"],
        total: json["total"],
        emailPegawai: json["email_pegawai"],
    );

    Map<String, dynamic> toJson() => {
        "diskon": diskon,
        "nama_diskon": namaDiskon,
        "total": total,
        "email_pegawai": emailPegawai,
    };
}
