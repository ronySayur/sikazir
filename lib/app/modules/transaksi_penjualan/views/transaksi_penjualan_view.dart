import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/app/models/detailKeranjang_model.dart';
import 'package:sikasir/app/models/product_model.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/theme.dart';
import 'package:sikasir/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controllers/transaksi_penjualan_controller.dart';

class TransaksiPenjualanView extends GetView<TransaksiPenjualanController> {
  final box = GetStorage();
  final rpid = NumberFormat("#,##0", "ID");

  TransaksiPenjualanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.emailPegawai = box.read("userEmail");
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(wDimension.height30 * 4.25),
          child: AppBar(
            backgroundColor: Colors.red[900],
            title: wBigText(text: "Transaksi", color: Colors.white),
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
                          controller.searchProduk(value);
                        },
                        controller: controller.searchC,
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
            stream: controller.streamAllKeranjang(),
            builder: (context, snapKeranjang) {
              if (snapKeranjang.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              List<DetailKeranjangModel> dataKeranjang = [];
              for (var k in snapKeranjang.data!.docs) {
                dataKeranjang.add(DetailKeranjangModel.fromJson(k.data()));
              }
              var cekTotalHarga = 0.obs;
              var cekTotalDiskon = 0.obs;
              //total harga
              snapKeranjang.data!.docs.forEach((doc) {
                cekTotalHarga += doc["total_harga"];
                cekTotalDiskon += doc["diskon"];
              });
              final cekHargaAwal = cekTotalHarga;
              controller.totalHarga = cekHargaAwal;
              final cekDiskonAwal = cekTotalDiskon;
              controller.totalDiskon = cekDiskonAwal;

              return SlidingUpPanel(
                  controller: controller.SUpanel,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  maxHeight: wDimension.heightSetengah,
                  minHeight: wDimension.screenHeight * 0.1,
                  panel: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      padding: EdgeInsets.all(wDimension.screenWidth * 0.06),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          wBigText(
                              color: Colors.black,
                              size: 24,
                              text:
                                  "${snapKeranjang.data!.docs.length} Barang"),
                          SizedBox(height: wDimension.height10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapKeranjang.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> dataK =
                                  snapKeranjang.data!.docs[index].data();

                              return InkWell(
                                onTap: () => Get.toNamed(
                                    Routes.UPDATE_KERANJANG,
                                    arguments: dataK),
                                child: Column(
                                  children: [
                                    SizedBox(height: wDimension.height10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        wBigText(text: dataK["nama_produk"]),
                                        const Icon(
                                          Icons.edit,
                                          size: 12,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        wSmallText(
                                            text:
                                                '${dataK["harga_jual"]} x ${dataK["jumlah"]}'),
                                        wSmallText(
                                            text:
                                                'Rp. ${rpid.format(dataK["total_harga"])}'),
                                      ],
                                    ),
                                    SizedBox(height: wDimension.height10),
                                    const Divider()
                                  ],
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    wBigText(
                                        color: Colors.black87,
                                        size: 16,
                                        weight: FontWeight.w300,
                                        text:
                                            'Total diskon: Rp.${rpid.format(controller.totalDiskon.value)}'),
                                    const SizedBox(height: 5),
                                    wBigText(
                                        color: Colors.black87,
                                        size: 16,
                                        weight: FontWeight.w300,
                                        text:
                                            'Total harga: Rp.${rpid.format(controller.totalHarga.value)}'),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    if (snapKeranjang.data!.docs.isNotEmpty) {
                                      await controller.saveNextToDetail();
                                      Get.toNamed(Routes.DETAIL_TRANSAKSI,
                                          arguments: [
                                            controller.totalHarga.value,
                                            controller.totalDiskon.value
                                          ]);
                                    } else {
                                      Get.snackbar("Peringatan",
                                          "Isi keranjang terlebih dahulu!",
                                          duration: const Duration(seconds: 1));
                                    }
                                  },
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: DesignAppTheme.nearlyBlue,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: DesignAppTheme.nearlyBlue
                                                .withOpacity(0.5),
                                            offset: const Offset(1.1, 1.1),
                                            blurRadius: 10.0)
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Lanjutkan",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          letterSpacing: 0.0,
                                          color: DesignAppTheme.nearlyWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).padding.bottom)
                        ],
                      ),
                    ),
                  ),
                  body: GetBuilder<TransaksiPenjualanController>(
                      builder: (controller) {
                    if (controller.searchC.text.isEmpty) {
                      return showProduk();
                    } else {
                      if (controller.tempSearch.isNotEmpty) {
                        List<ProdukModel> searchSup = [];

                        for (var element in controller.tempSearch) {
                          searchSup.add(ProdukModel.fromJson(element));
                        }
                        return showProduk();
                      } else {
                        return dataKosong('Produk');
                      }
                    }
                  }));
            }));
  }

  SingleChildScrollView showProduk() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamProduk(),
                builder: (context, snapProduk) {
                  if (snapProduk.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapProduk.data!.docs.isEmpty) {
                    return dataKosong('Produk');
                  }

                  List<ProdukModel> dataProdukJSON = [];

                  for (var element in snapProduk.data!.docs) {
                    dataProdukJSON.add(ProdukModel.fromJson(element.data()));
                  }

                  return Obx(() => GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 32.0,
                          crossAxisSpacing: 32.0,
                          childAspectRatio: 0.8,
                        ),
                        padding: const EdgeInsets.all(8),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.tempSearch.isNotEmpty
                            ? controller.tempSearch.length
                            : dataProdukJSON.length,
                        itemBuilder: (context, index) {
                          final int count = controller.tempSearch.isNotEmpty
                              ? controller.tempSearch.length
                              : dataProdukJSON.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: controller.animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn),
                            ),
                          );
                          controller.animationController?.forward();

                          return GetBuilder<TransaksiPenjualanController>(
                            init: TransaksiPenjualanController(),
                            initState: (_) {},
                            builder: (c) {
                              return AnimatedBuilder(
                                animation: c.animationController!,
                                builder: (BuildContext context, Widget? child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: Transform(
                                        transform: Matrix4.translationValues(
                                            0.0,
                                            50 * (1.0 - animation.value),
                                            0.0),
                                        child: SizedBox(
                                          height: 280,
                                          child: InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                if (controller
                                                    .searchC.text.isEmpty) {
                                                  c.tapKeranjangList(
                                                      dataProdukJSON[index]);
                                                } else {
                                                  List<ProdukModel> searchJSON =
                                                      [];

                                                  for (var element in controller
                                                      .tempSearch) {
                                                    searchJSON.add(
                                                        ProdukModel.fromJson(
                                                            element));
                                                  }

                                                  c.tapKeranjangList(
                                                      searchJSON[index]);
                                                }
                                              },
                                              child: Stack(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: DesignAppTheme
                                                                .grey
                                                                .withOpacity(
                                                                    0.08),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        16.0)),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              16,
                                                                          left:
                                                                              16,
                                                                          right:
                                                                              16),
                                                                      child:
                                                                          Text(
                                                                        controller.tempSearch.isNotEmpty
                                                                            ? controller.tempSearch[index]["nama_produk"].toUpperCase()
                                                                            : dataProdukJSON[index].namaProduk!.toUpperCase(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              0.27,
                                                                          color:
                                                                              DesignAppTheme.darkerText,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              8,
                                                                          left:
                                                                              16,
                                                                          right:
                                                                              16,
                                                                          bottom:
                                                                              8),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            '${dataProdukJSON[index].hargaJual} ',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 12,
                                                                              letterSpacing: 0.27,
                                                                              color: DesignAppTheme.grey,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '${dataProdukJSON[index].stok!} tersisa',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 12,
                                                                              letterSpacing: 0.27,
                                                                              color: DesignAppTheme.grey,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 48,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 48,
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 24,
                                                            right: 16,
                                                            left: 16),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    16.0)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: DesignAppTheme
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              offset:
                                                                  const Offset(
                                                                      0.0, 0.0),
                                                              blurRadius: 6.0),
                                                        ],
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    16.0)),
                                                        child: AspectRatio(
                                                            aspectRatio: 1.28,
                                                            child: dataProdukJSON[
                                                                            index]
                                                                        .fotoProduk ==
                                                                    "noimage"
                                                                ? Image.asset(
                                                                    "assets/logo/noproduk.png",
                                                                    fit: BoxFit
                                                                        .cover)
                                                                : Image.network(
                                                                    "${dataProdukJSON[index].fotoProduk}",
                                                                    fit: BoxFit
                                                                        .fill)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
