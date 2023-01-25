import 'package:get/get.dart';

import '../modules/add_pembelian/bindings/add_pembelian_binding.dart';
import '../modules/add_pembelian/views/add_pembelian_view.dart';
import '../modules/detail_supplier/bindings/detail_supplier_binding.dart';
import '../modules/detail_supplier/views/detail_supplier_view.dart';
import '../modules/detail_transaksi/bindings/detail_transaksi_binding.dart';
import '../modules/detail_transaksi/views/detail_transaksi_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_laporan/bindings/home_laporan_binding.dart';
import '../modules/home_laporan/views/home_laporan_view.dart';
import '../modules/home_pembelian/bindings/home_pembelian_binding.dart';
import '../modules/home_pembelian/views/home_pembelian_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/laporan/bindings/laporan_binding.dart';
import '../modules/laporan/views/laporan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/pegawai/addPegawai/bindings/add_pegawai_binding.dart';
import '../modules/pegawai/addPegawai/views/add_pegawai_view.dart';
import '../modules/pegawai/all_pegawai/bindings/all_pegawai_binding.dart';
import '../modules/pegawai/all_pegawai/views/all_pegawai_view.dart';
import '../modules/pegawai/detail_pegawai/bindings/detail_pegawai_binding.dart';
import '../modules/pegawai/detail_pegawai/views/detail_pegawai_view.dart';
import '../modules/pegawai/home_pegawai/bindings/home_pegawai_binding.dart';
import '../modules/pegawai/home_pegawai/views/home_pegawai_view.dart';
import '../modules/produk/add_produk/bindings/add_barang_binding.dart';
import '../modules/produk/add_produk/views/add_produk_view.dart';
import '../modules/produk/detail_produk/bindings/detail_produk_binding.dart';
import '../modules/produk/detail_produk/views/detail_produk_view.dart';
import '../modules/produk/home_produk/bindings/home_produk_binding.dart';
import '../modules/produk/home_produk/views/home_produk_view.dart';
import '../modules/produk/update_product/bindings/update_product_binding.dart';
import '../modules/produk/update_product/views/update_product_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/supplier/add_supplier/bindings/add_supplier_binding.dart';
import '../modules/supplier/add_supplier/views/add_supplier_view.dart';
import '../modules/supplier/home_supplier/bindings/home_supplier_binding.dart';
import '../modules/supplier/home_supplier/views/home_supplier_view.dart';
import '../modules/toko/add_toko/bindings/add_toko_binding.dart';
import '../modules/toko/add_toko/views/add_toko_view.dart';
import '../modules/toko/detail_toko/bindings/detail_toko_binding.dart';
import '../modules/toko/detail_toko/views/detail_toko_view.dart';
import '../modules/toko/home_toko/bindings/home_toko_binding.dart';
import '../modules/toko/home_toko/views/home_toko_view.dart';
import '../modules/toko/update_toko/bindings/update_toko_binding.dart';
import '../modules/toko/update_toko/views/update_toko_view.dart';
import '../modules/transaksi_penjualan/bindings/transaksi_penjualan_binding.dart';
import '../modules/transaksi_penjualan/views/transaksi_penjualan_view.dart';
import '../modules/transaksi_selesai/bindings/transaksi_selesai_binding.dart';
import '../modules/transaksi_selesai/views/transaksi_selesai_view.dart';
import '../modules/update_keranjang/bindings/update_keranjang_binding.dart';
import '../modules/update_keranjang/views/update_keranjang_view.dart';
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
        page: () => IntroductionView(),
        binding: IntroductionBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ADD_PRODUK,
        page: () => AddProdukView(),
        binding: AddProdukBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ADD_PEGAWAI,
        page: () => AddPegawaiView(),
        binding: AddPegawaiBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.NEW_PASSWORD,
        page: () => NewPasswordView(),
        binding: NewPasswordBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ADD_SUPPLIER,
        page: () => AddSupplierView(),
        binding: AddSupplierBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.FORGOT_PASSWORD,
        page: () => ForgotPasswordView(),
        binding: ForgotPasswordBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.UPDATE_PROFILE,
        page: () => UpdateProfileView(),
        binding: UpdateProfileBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.UPDATE_PASSWORD,
        page: () => UpdatePasswordView(),
        binding: UpdatePasswordBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.TRANSAKSI_PENJUALAN,
        page: () => TransaksiPenjualanView(),
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
        page: () => LaporanView(),
        binding: LaporanBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.HOME_PRODUK,
        page: () => HomeProdukView(),
        binding: HomeProdukBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.DETAIL_PRODUK,
        page: () => DetailProdukView(),
        binding: DetailProdukBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.UPDATE_PRODUCT,
        page: () => UpdateProductView(),
        binding: UpdateProductBinding(),
        transition: Transition.fadeIn),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.HOME_SUPPLIER,
      page: () => HomeSupplierView(),
      binding: HomeSupplierBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.DETAIL_SUPPLIER,
      page: () => DetailSupplierView(),
      binding: DetailSupplierBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.HOME_TOKO,
      page: () => HomeTokoView(),
      binding: HomeTokoBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.ADD_TOKO,
      page: () => AddTokoView(),
      binding: AddTokoBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.UPDATE_TOKO,
      page: () => UpdateTokoView(),
      binding: UpdateTokoBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.DETAIL_TOKO,
      page: () => DetailTokoView(),
      binding: DetailTokoBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.HOME_LAPORAN,
      page: () => HomeLaporanView(),
      binding: HomeLaporanBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.DETAIL_TRANSAKSI,
      page: () => DetailTransaksiView(),
      binding: DetailTransaksiBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.UPDATE_KERANJANG,
      page: () => UpdateKeranjangView(),
      binding: UpdateKeranjangBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PEMBELIAN,
      page: () => const HomePembelianView(),
      binding: HomePembelianBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PEMBELIAN,
      page: () => const AddPembelianView(),
      binding: AddPembelianBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI_SELESAI,
      page: () => const TransaksiSelesaiView(),
      binding: TransaksiSelesaiBinding(),
    ),
  ];
}
