import 'package:Search/screen/login/login_page.dart';
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
    // GetStorage dan ma'lumotlarni o'qish
    final String fullName = storage.read('name') ?? 'Ismingiz yoq';
    final String idNumber = storage.read('number') ?? 'Ma\'lumot yoq';

    return Container(
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width,
            color: const Color(0xffECD593),
            padding: const EdgeInsets.only(top: 30.0,left: 16,right: 16,bottom: 16),
            child: const Text(
              "Profel",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 20),
          // Foydalanuvchi ismini o'qish
          Text(
            fullName,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          // ID raqamini o'qish
          Text(
            idNumber,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          const Spacer(), // Bo'sh joy tugmani pastga surish uchun
          ElevatedButton(
            onPressed: () {
              // Chiqish tugmasi bosilganda
              storage.erase(); // Barcha saqlangan ma'lumotlarni o'chirish
              Get.offAll(() => const LoginPage()); // Login sahifasiga qaytarish
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              "Chiqish",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
