import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<dynamic> records = [];

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    final url = 'https://cyberkarshi.uz/app/figurant_api_v3.php';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          records = data['records'];
          print(records);
        });
      } else {
        throw Exception('Failed to load records');
      }
    } catch (e) {
      print("Error fetching records: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: records.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
        padding: const EdgeInsets.all(12.0),
        color: const Color(0xffF0F4F8),
        child: ListView.builder(
          itemCount: records.length,
          itemBuilder: (BuildContext context, int index) {
            final record = records[index];
            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Column(
                        children: [
                          const Text(
                            'Rasmiy qidiruv',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              record['photo'] != null && record['photo'] != "/interface/html/"
                                  ? 'https://cyberkarshi.uz/app${record['photo']}'
                                  : 'https://th.bing.com/th/id/OIP.5HyjPhedse6Qhpy7IOS8XgHaHa?rs=1&pid=ImgDetMain', // Default rasm URL
                              fit: BoxFit.cover,
                              height: 150,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            record['fio'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade800,
                            ),
                          ),
                          const SizedBox(height: 10),
                          InfoRow(title: "Tug'ilgan kun:", value: record['birth_date']),
                          InfoRow(title: "Manzil:", value: record['adress']),
                          InfoRow(title: "JK moddasi:", value: record['jk_modda']),
                          InfoRow(title: "QYJ vaqti:", value: record['qyj']),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
