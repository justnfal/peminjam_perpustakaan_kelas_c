import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:peminjam_perpustakaan_kelas_c/app/data/constant/endpoint.dart';
import 'package:peminjam_perpustakaan_kelas_c/app/data/provider/api_provider.dart';
import 'package:peminjam_perpustakaan_kelas_c/app/modules/book/controllers/book_controller.dart';
import 'package:peminjam_perpustakaan_kelas_c/app/modules/login/controllers/login_controller.dart';
import 'package:peminjam_perpustakaan_kelas_c/app/routes/app_pages.dart';

import '../../../data/provider/storage_provider.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loading = false.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  register() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.register,
            data: {
              "nama" : namaController.text.toString(),
              "username": usernameController.text.toString(),
              "telp": telpController.text.toString(),
              "alamat": alamatController.text.toString(),
              "password": passwordController.text.toString(),
            });
        if (response.statusCode == 201) {
          Get.snackbar("Berhasil", "Register berhasil", backgroundColor: Colors.red);
          Get.offAllNamed(Routes.LOGIN);
        } else {
          Get.snackbar("Sorry", "register", backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
