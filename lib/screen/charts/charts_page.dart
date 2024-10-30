import 'package:Search/screen/login/login_page.dart';
import 'package:Search/screen/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  List<dynamic> searchData = [];
  int countRasmiy = 0;
  int countPedding = 0;
  final GetStorage storage = GetStorage();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const String apiUrl = 'https://cyberkarshi.uz/app/public/api/charts';
    final token = storage.read('token');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchData = data['search'];
        countRasmiy = data['count_rasmiy'];
        countPedding = data['count_pedding'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              'Qashqadaryo viloyati IIB tomonidan qidiruvda bo’lgan fuqarolarning O’zbekiston hududida yurganlar to‘g‘risida tahliliy ma’lumot',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff1F3864),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(color: Color(0xff1F3864)),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.5),
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xffE7E7E7),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Tuman/Shahar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff1F3864),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Rasmiy qidiruvdagilar soni',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff1F3864),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Qidiruv bo\'lishi kutilayotganlar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff1F3864),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...searchData.map((item) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item['name'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff1F3864),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item['rasmiy'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff1F3864),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item['pedding'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff1F3864),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        TableRow(
                          decoration: const BoxDecoration(
                            color: Color(0xffE7E7E7),
                          ),
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Viloyat bo\'yicha',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff1F3864),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                countRasmiy.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xff1F3864),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                countPedding.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xff1F3864),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0,),
                IconButton(onPressed: (){
                  storage.remove('token');
                  Get.off(() => const LoginPage());
                }, icon: const Icon(Icons.logout_outlined),color: Colors.red,),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
