import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikasir/app/models/product_model.dart';

import '../../../../widgets/widgets.dart';
import '../../../routes/app_pages.dart';
import '../../home_produk/views/theme.dart';
import '../controllers/detail_produk_controller.dart';

class DetailProdukView extends GetView<DetailProdukController> {
  final ProdukModel dataProduk = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
                  child: dataProduk.fotoProduk == "noimage"
                      ? Image.asset("assets/logo/noproduk.png",
                          fit: BoxFit.cover)
                      : Image.network("${dataProduk.fotoProduk}",
                          fit: BoxFit.fill),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: [
                    BoxShadow(
                        color: DesignAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: controller.infoHeight,
                          maxHeight: tempHeight > controller.infoHeight
                              ? tempHeight
                              : controller.infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${dataProduk.namaProduk}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: DesignAppTheme.nearlyBlue,
                                  ),
                                ),
                                Text(
                                  'ID Produk: ${dataProduk.idProduk}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    letterSpacing: 0.1,
                                    color: DesignAppTheme.darkerText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: wDimension.height10),
                          Obx(() => AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: controller.opacity1.value.toDouble(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Row(
                                    children: [
                                      wTimeBoxUI(
                                          'Kategori', '${dataProduk.kategori}'),
                                      wTimeBoxUI('Merk', '${dataProduk.merek}'),
                                    ],
                                  ),
                                ),
                              )),
                          Obx(() => AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: controller.opacity1.value.toDouble(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Row(
                                    children: [
                                      wTimeBoxUI('Harga Modal',
                                          '${dataProduk.hargaModal}'),
                                      wTimeBoxUI('Harga Jual',
                                          '${dataProduk.hargaJual}'),
                                    ],
                                  ),
                                ),
                              )),
                          Obx(() => AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: controller.opacity1.value.toDouble(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Row(
                                    children: [
                                      wTimeBoxUI('Sisa Stok',
                                          '${dataProduk.stok} tersisa')
                                    ],
                                  ),
                                ),
                              )),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.UPDATE_PRODUCT,
                                  arguments: dataProduk);
                            },
                            child: Obx(() => AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: controller.opacity3.toDouble(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, bottom: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 48,
                                            decoration: BoxDecoration(
                                              color: DesignAppTheme.nearlyBlue,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(16.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: DesignAppTheme
                                                        .nearlyBlue
                                                        .withOpacity(0.5),
                                                    offset:
                                                        const Offset(1.1, 1.1),
                                                    blurRadius: 10.0),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Ubah Produk',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  letterSpacing: 0.0,
                                                  color: DesignAppTheme
                                                      .nearlyWhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              right: 30,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: controller.animationController!,
                    curve: Curves.fastOutSlowIn),
                child: InkWell(
                  onTap: () => Get.offNamed(Routes.UPDATE_PRODUCT,
                      arguments: dataProduk),
                  child: Card(
                    color: DesignAppTheme.nearlyBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    elevation: 10.0,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          color: DesignAppTheme.nearlyWhite,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width) - 20 - 35,
              right: 30,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: controller.animationController!,
                    curve: Curves.fastOutSlowIn),
                child: Card(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Icon(
                        Icons.store,
                        color: DesignAppTheme.nearlyWhite,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: DesignAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
