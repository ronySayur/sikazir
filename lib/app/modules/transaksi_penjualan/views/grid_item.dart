import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/app/models/product_model.dart';
import 'package:sikasir/app/routes/app_pages.dart';

import '../../../../../widgets/theme.dart';

Image fotoProdukKosong() {
  return Image.asset("assets/logo/noproduk.png", fit: BoxFit.fill);
}

class GridViewProdukTransaksi extends StatelessWidget {
  const GridViewProdukTransaksi({
    Key? key,
    required this.dataProduk,
    required this.animationController,
    this.animation,
  }) : super(key: key);

  final ProdukModel dataProduk;
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
              onTap: () {},
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
                                    Radius.circular(16.0))),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, left: 16, right: 16),
                                        child: Text(
                                          dataProduk.namaProduk!.toUpperCase(),
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
                                              '${dataProduk.hargaJual}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 12,
                                                letterSpacing: 0.27,
                                                color: DesignAppTheme.grey,
                                              ),
                                            ),
                                            Text(
                                              '${dataProduk.stok} tersisa',
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
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignAppTheme.grey.withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.28,
                                child: dataProduk.fotoProduk == "noimage"
                                    ? Image.asset("assets/logo/noproduk.png",
                                        fit: BoxFit.cover)
                                    : Image.network("${dataProduk.fotoProduk}",
                                        fit: BoxFit.fill)),
                          ),
                        ),
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
