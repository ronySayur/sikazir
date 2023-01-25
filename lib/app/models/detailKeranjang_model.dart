// To parse this JSON data, do
//
//     final detailKeranjangModel = detailKeranjangModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DetailKeranjangModel detailKeranjangModelFromJson(String str) => DetailKeranjangModel.fromJson(json.decode(str));

String detailKeranjangModelToJson(DetailKeranjangModel data) => json.encode(data.toJson());

class DetailKeranjangModel {
    DetailKeranjangModel({
        required this.idProduk,
        required this.namaProduk,
        required this.hargaJual,
        required this.hargaModal,
        required this.jumlah,
        required this.totalHarga,
    });

    String idProduk;
    String namaProduk;
    String hargaJual;
    String hargaModal;
    int jumlah;
    int totalHarga;

    factory DetailKeranjangModel.fromJson(Map<String, dynamic> json) => DetailKeranjangModel(
        idProduk: json["id_produk"],
        namaProduk: json["nama_produk"],
        hargaJual: json["harga_jual"],
        hargaModal: json["harga_modal"],
        jumlah: json["jumlah"],
        totalHarga: json["total_harga"],
    );

    Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "nama_produk": namaProduk,
        "harga_jual": hargaJual,
        "harga_modal": hargaModal,
        "jumlah": jumlah,
        "total_harga": totalHarga,
    };
}
