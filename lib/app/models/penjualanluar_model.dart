// To parse this JSON data, do
//
//     final penjualanLuarModel = penjualanLuarModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PenjualanLuarModel penjualanLuarModelFromJson(String str) => PenjualanLuarModel.fromJson(json.decode(str));

String penjualanLuarModelToJson(PenjualanLuarModel data) => json.encode(data.toJson());

class PenjualanLuarModel {
    PenjualanLuarModel({
        required this.diterima,
        required this.emailPegawai,
        required this.groupTanggal,
        required this.idPenjualan,
        required this.idToko,
        required this.tanggal,
        required this.total,
        required this.kembalian,
    });

    String diterima;
    String emailPegawai;
    String groupTanggal;
    String idPenjualan;
    String idToko;
    String tanggal;
    int total;
    int kembalian;

    factory PenjualanLuarModel.fromJson(Map<String, dynamic> json) => PenjualanLuarModel(
        diterima: json["diterima"],
        emailPegawai: json["email_pegawai"],
        groupTanggal: json["groupTanggal"],
        idPenjualan: json["id_penjualan"],
        idToko: json["id_toko"],
        tanggal: json["tanggal"],
        total: json["total"],
        kembalian: json["kembalian"],
    );

    Map<String, dynamic> toJson() => {
        "diterima": diterima,
        "email_pegawai": emailPegawai,
        "groupTanggal": groupTanggal,
        "id_penjualan": idPenjualan,
        "id_toko": idToko,
        "tanggal": tanggal,
        "total": total,
        "kembalian": kembalian,
    };
}
