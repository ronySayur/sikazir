import 'package:get/get.dart';

import '../modules/addPegawai/bindings/add_pegawai_binding.dart';
import '../modules/addPegawai/views/add_pegawai_view.dart';
import '../modules/add_produk/bindings/add_barang_binding.dart';
import '../modules/add_produk/views/add_produk_view.dart';
import '../modules/add_supplier/bindings/add_supplier_binding.dart';
import '../modules/add_supplier/views/add_supplier_view.dart';
import '../modules/all_pegawai/bindings/all_pegawai_binding.dart';
import '../modules/all_pegawai/views/all_pegawai_view.dart';
import '../modules/detail_pegawai/bindings/detail_pegawai_binding.dart';
import '../modules/detail_pegawai/views/detail_pegawai_view.dart';
import '../modules/detail_produk/bindings/detail_produk_binding.dart';
import '../modules/detail_produk/views/detail_produk_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_pegawai/bindings/home_pegawai_binding.dart';
import '../modules/home_pegawai/views/home_pegawai_view.dart';
import '../modules/home_produk/bindings/home_produk_binding.dart';
import '../modules/home_produk/views/home_produk_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/laporan/bindings/laporan_binding.dart';
import '../modules/laporan/views/laporan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/transaksi_penjualan/bindings/transaksi_penjualan_binding.dart';
import '../modules/transaksi_penjualan/views/transaksi_penjualan_view.dart';
import '../modules/update_password/bindings/update_password_binding.dart';
import '../modules/update_password/views/update_password_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.INTRODUCTION,
        page: () => const IntroductionView(),
        binding: IntroductionBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ADD_PRODUK,
        page: () =>  AddProdukView(),
        binding: AddProdukBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ADD_PEGAWAI,
        page: () => AddPegawaiView(),
        binding: AddPegawaiBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.NEW_PASSWORD,
        page: () => const NewPasswordView(),
        binding: NewPasswordBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ADD_SUPPLIER,
        page: () => AddSupplierView(),
        binding: AddSupplierBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.FORGOT_PASSWORD,
        page: () => const ForgotPasswordView(),
        binding: ForgotPasswordBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.PROFILE,
        page: () => const ProfileView(),
        binding: ProfileBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.UPDATE_PROFILE,
        page: () => UpdateProfileView(),
        binding: UpdateProfileBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.UPDATE_PASSWORD,
        page: () => const UpdatePasswordView(),
        binding: UpdatePasswordBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.TRANSAKSI_PENJUALAN,
        page: () => const TransaksiPenjualanView(),
        binding: TransaksiPenjualanBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.HOME_PEGAWAI,
        page: () => HomePegawaiView(),
        binding: HomePegawaiBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ALL_PEGAWAI,
        page: () => AllPegawaiView(),
        binding: AllPegawaiBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.DETAIL_PEGAWAI,
        page: () => DetailPegawaiView(),
        binding: DetailPegawaiBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.LAPORAN,
        page: () => const LaporanView(),
        binding: LaporanBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.HOME_PRODUK,
      page: () => const HomeProdukView(),
      binding: HomeProdukBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUK,
      page: () => const DetailProdukView(),
      binding: DetailProdukBinding(),
    ),
  ];
}
