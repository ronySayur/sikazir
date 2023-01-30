import 'package:flutter/material.dart';
import 'package:sikasir/app/modules/home/components/responsive.dart';
import 'package:sikasir/app/modules/home/components/settingCard.dart';

import '../../../../widgets/widgets.dart';

class bodyDashboard extends StatelessWidget {
  const bodyDashboard({
    Key? key,
    required this.user,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Map<String, dynamic> user;
  final Size _size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                primary: false,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      wBigText(
                                        text:
                                            "Selamat Datang ${user["nama_pegawai"]}",
                                        color: primaryColor,
                                        // ),
                                        // ElevatedButton.icon(
                                        //   style: TextButton.styleFrom(
                                        //     padding: EdgeInsets.symmetric(
                                        //       horizontal: defaultPadding * 1.5,
                                        //       vertical: defaultPadding /
                                        //           (Responsive.isMobile(context)
                                        //               ? 2
                                        //               : 1),
                                        //     ),
                                        //   ),
                                        //   onPressed: () => Get.toNamed(
                                        //       Routes.TRANSAKSI_PENJUALAN),
                                        //   icon: Icon(Icons.add),
                                        //   label: Text("Tambah Transaksi"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  Responsive(
                                    mobile: gridCard(
                                      crossAxisCount: _size.width < 650 ? 2 : 4,
                                      childAspectRatio:
                                          _size.width < 650 ? 1.3 : 1,
                                    ),
                                    tablet: const gridCard(),
                                    desktop: gridCard(
                                      childAspectRatio:
                                          _size.width < 1400 ? 1.1 : 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
