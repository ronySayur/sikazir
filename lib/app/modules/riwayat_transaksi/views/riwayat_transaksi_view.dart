import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/riwayat_transaksi_controller.dart';

class RiwayatTransaksiView extends GetView<RiwayatTransaksiController> {
  RiwayatTransaksiView({Key? key}) : super(key: key);
  final rpid = NumberFormat("#,##0", "ID");
  final dpid = DateFormat('HH:mm');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(wDimension.height30 * 4.25),
          child: AppBar(
            backgroundColor: Colors.red[900],
            title: wBigText(text: "Riwayat Transaksi", color: Colors.white),
            centerTitle: false,
            flexibleSpace: Padding(
                padding: EdgeInsets.fromLTRB(
                    wDimension.height30,
                    wDimension.height10 * 5,
                    wDimension.height20,
                    wDimension.height20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextField(
                        onChanged: (value) {
                          // controller.searchProduk(value);
                        },
                        // controller: controller.searchC,
                        cursorColor: Colors.red[900],
                        autocorrect: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(wDimension.height45),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: wDimension.width10 / 10)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(wDimension.height45),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: wDimension.width10 / 10)),
                          hintText: "Search..",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: wDimension.height30,
                              vertical: wDimension.height20),
                        )))),
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamTrans(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return dataKosong("Riwayat");
              }
              var alldata = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: alldata.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          SizedBox(height: wDimension.height10),
                          wSmallText(
                              weight: FontWeight.bold,
                              text: "${alldata[index]["groupTanggal"]}"),
                          ListTile(
                            onTap: () => Get.toNamed(Routes.DETAIL_RIWAYAT,arguments: alldata[index]),
                            leading: const Icon(Icons.receipt_long),
                            title: wSmallText(
                              text: "#${alldata[index]["id_penjualan"]}",
                              size: 18,
                              color: Colors.black,
                              weight: FontWeight.bold,
                            ),
                            subtitle: Text(dpid.format(
                                DateTime.parse(alldata[index]["tanggal"]))),
                            trailing: Icon(Icons.navigate_next),
                          )
                        ],
                      );
                    } else {
                      //return tanpa kolom
                      if (alldata[index]["groupTanggal"] ==
                          alldata[index - 1]["groupTanggal"]) {
                        return ListTile(
                            onTap: () => Get.toNamed(Routes.DETAIL_RIWAYAT,arguments: alldata[index]["id_penjualan"]),

                          leading: const Icon(Icons.receipt_long),
                          title: wSmallText(
                            
                            text: "#${alldata[index]["id_penjualan"]}",
                            size: 18,
                            color: Colors.black,
                            weight: FontWeight.bold,
                          ),
                          subtitle: Text(dpid.format(
                              DateTime.parse(alldata[index]["tanggal"]))),
                          trailing: Icon(Icons.navigate_next),
                        );
                      } else {
                        //return kolom
                        return Column(
                          children: [
                            wSmallText(
                                weight: FontWeight.bold,
                                text: "${alldata[index]["groupTanggal"]}"),
                            ListTile(
                            onTap: () => Get.toNamed(Routes.DETAIL_RIWAYAT,arguments: alldata[index]["id_penjualan"]),

                              leading: const Icon(Icons.receipt_long),
                              title: wSmallText(
                                text: "#${alldata[index]["id_penjualan"]}",
                                size: 18,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              subtitle: Text(dpid.format(
                                  DateTime.parse(alldata[index]["tanggal"]))),
                              trailing: Icon(Icons.navigate_next),
                            )
                          ],
                        );
                      }
                    }
                  });
            }));
  }
}
