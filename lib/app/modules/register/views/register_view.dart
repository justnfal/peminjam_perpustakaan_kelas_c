import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterView'),
        centerTitle: true,
      ),
      body: Center(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.namaController,
                  decoration: InputDecoration(hintText: "nama"),
                  validator: (value) {
                    if (value!.length < 2) {
                      return "nama tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.usernameController,
                  decoration: InputDecoration(hintText: "username"),
                  validator: (value) {
                    if (value!.length < 2) {
                      return "username tidak boleh kosong";
                    }
                    return null;
                  },
                ),TextFormField(
                  controller: controller.telpController,
                  decoration: InputDecoration(hintText: "Nomor Telephon"),
                  validator: (value) {
                    if (value!.length < 2) {
                      return "Nomor Telephon tidak boleh kosong";
                    }
                    return null;
                  },
                ),TextFormField(
                  controller: controller.alamatController,
                  decoration: InputDecoration(hintText: "Alamat"),
                  validator: (value) {
                    if (value!.length < 2) {
                      return "alamat terbit tidak boleh kosong";
                    }
                    return null;
                  },
                ),TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "password"),
                  validator: (value) {
                    if (value!.length < 2) {
                      return "password tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                Obx(() => controller.loading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                    onPressed: () {
                      controller.register();
                    },
                    child: Text("Register"))),
                ElevatedButton(onPressed: ()=>Get.toNamed(Routes.LOGIN),
                    child: Text("Kembali ke Login")),
                // ElevatedButton(onPressed: (){controller.login();}, child: Text("Login"))
              ],
            ),
          )),
    );
  }
}
