// To parse this JSON data, do
//
//     final produkModel = produkModelFromJson(jsonString);

import 'dart:convert';

ProdukModel? produkModelFromJson(String str) => ProdukModel.fromJson(json.decode(str));

String produkModelToJson(ProdukModel? data) => json.encode(data!.toJson());

class ProdukModel {
    ProdukModel({
        required this.idProduk,
        required this.fotoProduk,
        required this.hargaJual,
        required this.hargaModal,
        required this.kategori,
        required this.merek,
        required this.emailPegawai,
        required this.namaProduk,
        required this.stok,
        required this.emailVendor,
        required this.idToko,
    });

    String? idProduk;
    String? fotoProduk;
    String? hargaJual;
    String? hargaModal;
    String? kategori;
    String? merek;
    String? emailPegawai;
    String? namaProduk;
    int? stok;
    String? emailVendor;
    String? idToko;

    factory ProdukModel.fromJson(Map<String, dynamic> json) => ProdukModel(
        idProduk: json["id_produk"],
        fotoProduk: json["foto_produk"],
        hargaJual: json["harga_jual"],
        hargaModal: json["harga_modal"],
        kategori: json["kategori"],
        merek: json["merek"],
        emailPegawai: json["email_pegawai"],
        namaProduk: json["nama_produk"],
        stok: json["stok"],
        emailVendor: json["email_vendor"],
        idToko: json["id_toko"],
    );

    Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "foto_produk": fotoProduk,
        "harga_jual": hargaJual,
        "harga_modal": hargaModal,
        "kategori": kategori,
        "merek": merek,
        "email_pegawai": emailPegawai,
        "nama_produk": namaProduk,
        "stok": stok,
        "email_vendor": emailVendor,
        "id_toko": idToko,
    };
}
