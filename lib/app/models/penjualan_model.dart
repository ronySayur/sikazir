import 'dart:convert';

PenjualanModel penjualanModelFromJson(String str) =>
    PenjualanModel.fromJson(json.decode(str));

String penjualanModelToJson(PenjualanModel data) => json.encode(data.toJson());

class PenjualanModel {
  PenjualanModel({
    required this.idPennjualan,
    required this.detailTransaksi,
    required this.emailPegawai,
    required this.tanggal,
    required this.total,
    required this.idToko,
  });

  String idPennjualan;
  String detailTransaksi;
  String emailPegawai;
  String tanggal;
  String total;
  String idToko;

  factory PenjualanModel.fromJson(Map<String, dynamic> json) => PenjualanModel(
        idPennjualan: json["id_pennjualan"],
        detailTransaksi: json["detail_transaksi"],
        emailPegawai: json["email_pegawai"],
        tanggal: json["tanggal"],
        total: json["total"],
        idToko: json["id_toko"],
      );

  Map<String, dynamic> toJson() => {
        "id_pennjualan": idPennjualan,
        "detail_transaksi": detailTransaksi,
        "email_pegawai": emailPegawai,
        "tanggal": tanggal,
        "total": total,
        "id_toko": idToko,
      };
}
