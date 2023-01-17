import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sikasir/widgets/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../models/product_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_produk_controller.dart';

class HomeProdukView extends GetView<HomeProdukController> {
  const HomeProdukView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
        backgroundColor: Colors.red,
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () => Get.toNamed(Routes.ADD_PRODUK),
              child: Container(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(wDimension.radius30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    wSmallText(
                      text: "Tambah Produk",
                      color: Colors.lightBlue,
                      size: wDimension.iconSize16,
                      weight: FontWeight.bold,
                      align: TextAlign.end,
                    ),
                    SizedBox(width: wDimension.width10 / 2),
                    const Icon(Icons.add_box_sharp)
                  ],
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            //Search

            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.streamProduk(),
              builder: (context, snapProducts) {
                if (snapProducts.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapProducts.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Lottie.asset("assets/lottie/empty.json"),
                        wBigText(text: "Produk Kosong")
                      ],
                    ),
                  );
                }

                List<ProdukModel> allProducts = [];

                for (var element in snapProducts.data!.docs) {
                  allProducts.add(ProdukModel.fromJson(element.data()));
                }

                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Search..."),
                      ),
                    ),
                    ListView.builder(
                      itemCount: allProducts.length,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        ProdukModel product = allProducts[index];
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.only(bottom: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_PRODUK);
                            },
                            borderRadius: BorderRadius.circular(9),
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.idProduk,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(product.namaProduk),
                                        Text("Jumlah : ${product.stok}"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: QrImage(
                                      data: product.idProduk,
                                      size: 200.0,
                                      version: QrVersions.auto,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PRODUK),
        child: const Icon(Icons.add),
      ),
    );
  }
}
