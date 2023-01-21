// To parse this JSON data, do
//
//     final supplierModel = supplierModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SupplierModel supplierModelFromJson(String str) =>
    SupplierModel.fromJson(json.decode(str));

String supplierModelToJson(SupplierModel data) => json.encode(data.toJson());

class SupplierModel {
  SupplierModel({
    required this.idSupplier,
    required this.emailVendor,
    required this.noPic,
    required this.alamatVendor,
    required this.jabatanPic,
    required this.namaPic,
    required this.namaVendor,
    required this.noVendor,
  });

  String idSupplier;
  String emailVendor;
  String noPic;
  String alamatVendor;
  String jabatanPic;
  String namaPic;
  String namaVendor;
  String noVendor;

  factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
        idSupplier: json["id_supplier"],
        emailVendor: json["email_vendor"],
        noPic: json["no_pic"],
        alamatVendor: json["alamat_vendor"],
        jabatanPic: json["jabatan_pic"],
        namaPic: json["nama_pic"],
        namaVendor: json["nama_vendor"],
        noVendor: json["no_vendor"],
      );

  Map<String, dynamic> toJson() => {
        "id_supplier": idSupplier,
        "email_vendor": emailVendor,
        "no_pic": noPic,
        "alamat_vendor": alamatVendor,
        "jabatan_pic": jabatanPic,
        "nama_pic": namaPic,
        "nama_vendor": namaVendor,
        "no_vendor": noVendor,
      };
}
