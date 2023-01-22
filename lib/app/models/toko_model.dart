// To parse this JSON data, do
//
//     final tokoModel = tokoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TokoModel tokoModelFromJson(String str) => TokoModel.fromJson(json.decode(str));

String tokoModelToJson(TokoModel data) => json.encode(data.toJson());

class TokoModel {
    TokoModel({
        required this.idToko,
        required this.namaToko,
        required this.emailToko,
        required this.alamat,
        required this.noTelp,
    });

    String idToko;
    String namaToko;
    String emailToko;
    String alamat;
    String noTelp;

    factory TokoModel.fromJson(Map<String, dynamic> json) => TokoModel(
        idToko: json["id_toko"],
        namaToko: json["nama_toko"],
        emailToko: json["email_toko"],
        alamat: json["alamat"],
        noTelp: json["no_telp"],
    );

    Map<String, dynamic> toJson() => {
        "id_toko": idToko,
        "nama_toko": namaToko,
        "email_toko": emailToko,
        "alamat": alamat,
        "no_telp": noTelp,
    };
}
