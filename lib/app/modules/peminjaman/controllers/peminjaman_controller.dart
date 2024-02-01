import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:peminjam_perpustakaan_kelas_c/app/data/model/response_pinjam.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_register.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
class PeminjamanController extends GetxController with StateMixin<List<DataPeminjaman>>{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async {
    change(null, status: RxStatus.loading());
    try {
      final response = 
      await ApiProvider.instance().get("${Endpoint.pinjam}/${StorageProvider.read(StorageKey.idUser)}");
      if (response.statusCode == 200) {
        final ResponsePinjam responsebooks = ResponsePinjam.fromJson(response.data);
        if (responsebooks.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(responsebooks.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Mengambil data"));
      }


    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

}
