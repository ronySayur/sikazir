import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/app/models/supplier_model.dart';
import 'package:sikasir/app/routes/app_pages.dart';

import '../../../../../widgets/theme.dart';

class SearchGridViewS extends StatelessWidget {
  const SearchGridViewS({
    Key? key,
    required this.dataSupplier,
    required this.animationController,
    this.animation,
  }) : super(key: key);

  final Map<String, dynamic> dataSupplier;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () =>
                  Get.toNamed(Routes.DETAIL_SUPPLIER, arguments: dataSupplier),
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: DesignAppTheme.grey.withOpacity(0.08),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16, left: 16, right: 16),
                                          child: Text(
                                            dataSupplier["nama_pic"]
                                                .toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              letterSpacing: 0.27,
                                              color: DesignAppTheme.darkerText,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              left: 16,
                                              right: 16,
                                              bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${dataSupplier["stok"]}',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GridViewS extends StatelessWidget {
  const GridViewS({
    Key? key,
    required this.dataSupplier,
    required this.animationController,
    this.animation,
  }) : super(key: key);

  final SupplierModel dataSupplier;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () =>
                  Get.toNamed(Routes.DETAIL_SUPPLIER, arguments: dataSupplier),
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: DesignAppTheme.grey.withOpacity(0.08),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0)),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, left: 16, right: 16),
                                        child: Text(
                                          dataSupplier.namaPic.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.27,
                                            color: DesignAppTheme.darkerText,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            left: 16,
                                            right: 16,
                                            bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              dataSupplier.emailVendor,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w200,
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
