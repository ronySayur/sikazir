import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/app/models/supplier_model.dart';
import 'package:sikasir/app/routes/app_pages.dart';

import '../../../../../widgets/theme.dart';

class GridViewS extends StatelessWidget {
  const GridViewS({
    Key? key,
    required this.dataSupplierModel,
    required this.animationController,
    this.animation,
  }) : super(key: key);

  final SupplierModel dataSupplierModel;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    String defaultImage =
        "https://ui-avatars.com/api/?name=${dataSupplierModel.namaVendor}";

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
              onTap: () => Get.toNamed(Routes.DETAIL_SUPPLIER,
                  arguments: dataSupplierModel),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8, top: 8),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(defaultImage)),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16,
                                            left: 16,
                                            right: 16,
                                            bottom: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dataSupplierModel.namaVendor,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22,
                                                letterSpacing: 0.27,
                                                color: DesignAppTheme.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${dataSupplierModel.emailVendor}\n${dataSupplierModel.alamatVendor}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: 0.27,
                                                    color: DesignAppTheme.grey,
                                                  ),
                                                ),
                                                Text(
                                                  '${dataSupplierModel.jabatanPic}\n${dataSupplierModel.namaPic}\n${dataSupplierModel.noPic}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: 0.27,
                                                    color: DesignAppTheme.grey,
                                                  ),
                                                ),
                                              ],
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
