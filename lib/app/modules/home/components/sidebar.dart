import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/logo/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () => Get.toNamed(Routes.HOME),
          ),
          DrawerListTile(
            title: "Transaksi",
            svgSrc: "assets/icons/transactions.svg",
            press: () => Get.toNamed(Routes.TRANSAKSI_PENJUALAN),
          ),
          DrawerListTile(
            title: "Produk",
            svgSrc: "assets/icons/product.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Supplier",
            svgSrc: "assets/icons/supplier.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Toko",
            svgSrc: "assets/icons/toko.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Pegawai",
            svgSrc: "assets/icons/employee.svg",
            press: () => Get.toNamed(Routes.HOME_PEGAWAI),
          ),
          DrawerListTile(
            title: "Laporan",
            svgSrc: "assets/icons/reports.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
