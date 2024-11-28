import 'package:Qidruv/screen/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfelPage extends StatefulWidget {
  const ProfelPage({super.key});

  @override
  State<ProfelPage> createState() => _ProfelPageState();
}

class _ProfelPageState extends State<ProfelPage> {
  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final String fullName = storage.read('name') ?? '___';
    final String idNumber = storage.read('number') ?? '___';
    final String? userImage = storage.read('image'); // Rasim uchun

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffECD593),
      ),
      body: Center(
        child: Container(
          width: Get.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Foydalanuvchi rasmi
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage('https://renault.glass-united.ru/images/avatar-review.png'),
                backgroundColor: Colors.grey.shade200,
              ),
              const SizedBox(height: 16.0),
              // Foydalanuvchi ismi
              Text(
                fullName,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              // ID raqami
              Text(
                idNumber,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 1.0,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              // Chiqish tugmasi
              ElevatedButton(
                onPressed: () {
                  storage.erase();
                  Get.offAll(() => const LoginPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "Chiqish",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
