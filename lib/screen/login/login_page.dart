import 'dart:convert';
import 'package:doc2/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController guvohnomaController = TextEditingController();
  final TextEditingController jetonController = TextEditingController();
  final GetStorage storage = GetStorage();
  bool isLoading = false;

  Future<void> loginUser() async {
    final String guvohnomaRaqami = guvohnomaController.text;
    final String jetonRaqami = jetonController.text;

    if (guvohnomaRaqami.isEmpty || jetonRaqami.isEmpty) {
      Get.snackbar('Xato', 'Iltimos, barcha maydonlarni to\'ldiring.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://edumeneger.uz/api/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': guvohnomaRaqami,
          'password': jetonRaqami,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        storage.write('token', responseData['token']);
        print('Token: $token');

        Get.to(() => const HomePage());
      } else {
        Get.snackbar('Xato', 'Login yoki parol noto\'g\'ri.');
      }
    } catch (error) {
      Get.snackbar('Xato', 'Nimadir xato ketdi. Iltimos, qayta urinib ko\'ring.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffF7F8FA), Color(0xffEDD692)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assest/image/logo.png',
                    height: 180,
                    width: 180,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'TIZIMGA KIRISH UCHUN MA\'LUMOTLARINGIZNI KIRITING',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff1F3864),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: Get.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'GUVOHNOMA RAQAMI:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff444F5E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: guvohnomaController,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            hintText: '002863',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'JETON RAQAMI:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff444F5E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: jetonController,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            hintText: 'A-088007',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: Get.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1F3864),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading ? null : loginUser,
                      child: isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(
                        'TIZIMGA KIRISH',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
