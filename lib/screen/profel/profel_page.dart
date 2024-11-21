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
    final String fullName = storage.read('name') ?? 'Ismingiz yoq';
    final String idNumber = storage.read('number') ?? 'Ma\'lumot yoq';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profel',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xffECD593),
      ),
      body: Center(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                fullName,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                idNumber,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  storage.erase();
                  Get.offAll(() => const LoginPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
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
        ),
      ),
    );
  }
}
