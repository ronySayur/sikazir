import 'package:get/get.dart';

import '../modules/addBarang/bindings/add_barang_binding.dart';
import '../modules/addBarang/views/add_barang_view.dart';
import '../modules/addPegawai/bindings/add_pegawai_binding.dart';
import '../modules/addPegawai/views/add_pegawai_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BARANG,
      page: () => const AddBarangView(),
      binding: AddBarangBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PEGAWAI,
      page: () =>  AddPegawaiView(),
      binding: AddPegawaiBinding(),
    ),
  ];
}
