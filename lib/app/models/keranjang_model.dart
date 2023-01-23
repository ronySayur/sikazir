// To parse this JSON data, do
//
//     final keranjangModel = keranjangModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KeranjangModel keranjangModelFromJson(String str) => KeranjangModel.fromJson(json.decode(str));

String keranjangModelToJson(KeranjangModel data) => json.encode(data.toJson());

class KeranjangModel {
    KeranjangModel({
        required this.idProduk,
        required this.idKeranjang,
        required this.namaProduk,
        required this.hargaJual,
        required this.hargaModal,
        required this.jumlah,
        required this.diskon,
        required this.namaDiskon,
        required this.totalHarga,
        required this.emailPegawai,
    });

    String idProduk;
    String idKeranjang;
    String namaProduk;
    String hargaJual;
    String hargaModal;
    int jumlah;
    int diskon;
    String namaDiskon;
    int totalHarga;
    String emailPegawai;

    factory KeranjangModel.fromJson(Map<String, dynamic> json) => KeranjangModel(
        idProduk: json["id_produk"],
        idKeranjang: json["id_keranjang"],
        namaProduk: json["nama_produk"],
        hargaJual: json["harga_jual"],
        hargaModal: json["harga_modal"],
        jumlah: json["jumlah"],
        diskon: json["diskon"],
        namaDiskon: json["nama_diskon"],
        totalHarga: json["total_harga"],
        emailPegawai: json["email_pegawai"],
    );

    Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "id_keranjang": idKeranjang,
        "nama_produk": namaProduk,
        "harga_jual": hargaJual,
        "harga_modal": hargaModal,
        "jumlah": jumlah,
        "diskon": diskon,
        "nama_diskon": namaDiskon,
        "total_harga": totalHarga,
        "email_pegawai": emailPegawai,
    };
}
