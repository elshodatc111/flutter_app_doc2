import 'package:doc2/screen/home_page.dart';
import 'package:doc2/screen/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GetStorage storage = GetStorage();
    String? token = storage.read('token');
    Future.delayed(const Duration(seconds: 5), () {
      if (token != null && token.isNotEmpty) {
        Get.off(() => const HomePage());
      } else {
        Get.off(() => const LoginPage());
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffE9EAF1), Color(0xffD3C0AC), Color(0xffEDD692)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
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
                'QASHQADARYO VILOYATI IIB',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xff1F3864),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'TEZKOR QIDIRUV XIZMATI',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff1F3864),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                'QIDIRUV ISHINI TASHKIL ETISH BO\'LIMI',
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xff1F3864),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Qashqadaryo viloyati IIB tomonidan qidiruvda bo\'lgan shaxslar to\'g\'risida ma\'lumot',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff1F3864),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 80),
              const Text(
                'Qashqadaryo viloyati IIB TQX Kiberxafsizlik bo\'limi tomonidan ishlab chiqilgan',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff1F3864),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
