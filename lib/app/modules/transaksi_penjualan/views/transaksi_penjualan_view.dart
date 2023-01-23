import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikasir/app/controllers/auth_controller.dart';
import 'package:sikasir/app/models/keranjang_model.dart';
import 'package:sikasir/app/models/product_model.dart';
import 'package:sikasir/app/modules/transaksi_penjualan/views/grid_item.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/theme.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/transaksi_penjualan_controller.dart';

class TransaksiPenjualanView extends GetView<TransaksiPenjualanController> {
  final authC = Get.find<AuthController>();

  TransaksiPenjualanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                        controller.ontap.toggle();
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

            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: authC.streamUser(),
                builder: (context, snapUser) {
                  if (snapUser.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  Map<String, dynamic> currentUser = snapUser.data!.data()!;

                  return GetBuilder<TransaksiPenjualanController>(
                      builder: (controller) {
                    if (controller.searchC.text.isEmpty) {
                      List<ProdukModel> allProd = [];

                      for (var element in snapProduk.data!.docs) {
                        allProd.add(ProdukModel.fromJson(element.data()));
                      }

                      return showProduk(allProd, currentUser);
                    } else {
                      if (controller.tempSearch.isNotEmpty) {
                        List<ProdukModel> searchSup = [];

                        for (var element in controller.tempSearch) {
                          searchSup.add(ProdukModel.fromJson(element));
                        }
                        return showProduk(searchSup, currentUser);
                      } else {
                        return dataKosong('Produk');
                      }
                    }
                  });
                });
          }),
    );
  }

  SingleChildScrollView showProduk(
      List<ProdukModel> dataProdukJSON, Map<String, dynamic> currentUser) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dataProdukJSON.length,
              itemBuilder: (context, index) {
                final int count = dataProdukJSON.length;
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
                                  0.0, 50 * (1.0 - animation.value), 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  if (c.isLoading.isFalse) {
                                    c.addKeranjang(
                                        currentUser, dataProdukJSON[index]);
                                  }
                                  c.isLoading.isFalse;
                                },
                                child: SizedBox(
                                  height: 280,
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: DesignAppTheme.grey
                                                    .withOpacity(0.08),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16.0)),
                                              ),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 16,
                                                                  left: 16,
                                                                  right: 16),
                                                          child: Text(
                                                            dataProdukJSON[
                                                                    index]
                                                                .namaProduk!
                                                                .toUpperCase(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0.27,
                                                              color:
                                                                  DesignAppTheme
                                                                      .darkerText,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8,
                                                                  left: 16,
                                                                  right: 16,
                                                                  bottom: 8),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                '${dataProdukJSON[index].stok} tersisa',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                  fontSize: 12,
                                                                  letterSpacing:
                                                                      0.27,
                                                                  color:
                                                                      DesignAppTheme
                                                                          .grey,
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
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 24, right: 16, left: 16),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: DesignAppTheme.grey
                                                        .withOpacity(0.2),
                                                    offset:
                                                        const Offset(0.0, 0.0),
                                                    blurRadius: 6.0),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16.0)),
                                              child: AspectRatio(
                                                  aspectRatio: 1.28,
                                                  child: dataProdukJSON[index]
                                                              .fotoProduk ==
                                                          "noimage"
                                                      ? Image.asset(
                                                          "assets/logo/noproduk.png",
                                                          fit: BoxFit.cover)
                                                      : Image.network(
                                                          "${dataProdukJSON[index].fotoProduk}",
                                                          fit: BoxFit.fill)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
