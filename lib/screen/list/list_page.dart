import 'package:Qidruv/screen/list/list_show_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<dynamic> searchResults = [];
  final GetStorage storage = GetStorage();

  @override
  void initState() {
    super.initState();
    fetchSearchData();
  }

  Future<void> fetchSearchData() async {
    final token = storage.read('token');
    final response = await http.get(
      Uri.parse('https://cyberkarshi.uz/app/public/api/search'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchResults = data['search'];
      });
    } else {
      print('Failed to load data');
    }
  }

  void navigateToListShowPage(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListShowPage(id: id), // Pass the id to ListShowPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Qidruvdagi shaxslar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xffECD593),
      ),
      body: searchResults.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final item = searchResults[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16.0)),
                      child: Image.network(
                        'https://cyberkarshi.uz/app/public/photo/${item['photo']}',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                    // Type Badge
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: item['type'] == "1"
                              ? Colors.red.withOpacity(0.8)
                              : Colors.orange.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          item['type'] == "1"
                              ? "Rasmiy qidiruv"
                              : "Qidruv kutilmoqda",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Center(
                        child: Text(
                          item['fio'] ?? 'No FIO',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Substance
                      _buildInfoRow('JK moddasi:', item['substance']),
                      // Address
                      _buildInfoRow('Manzil:', item['adress']),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Save Button
                      ElevatedButton.icon(
                        onPressed: () async {
                          Map<String, dynamic> itemData = {
                            'id': item['id'],
                            'name': item['name'],
                            'fio': item['fio'],
                            'substance': item['substance'],
                            'address': item['adress'],
                            'photo': item['photo'],
                            'type': item['type'],
                          };
                          List<Map<String, dynamic>> savedData = (storage
                              .read<List<dynamic>>(
                              'savedSearchData') ??
                              [])
                              .cast<Map<String, dynamic>>();
                          bool isAlreadySaved = savedData.any(
                                  (data) => data['id'] == itemData['id']);
                          if (!isAlreadySaved) {
                            savedData.add(itemData);
                            await storage.write(
                                'savedSearchData', savedData);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Ma\'lumot muvaffaqiyatli saqlandi!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Ma\'lumot avval saqlangan!')),
                            );
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Saqlash"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      // More Info Button
                      ElevatedButton.icon(
                        onPressed: () => navigateToListShowPage(
                            item['id'].toString()),
                        icon: const Icon(Icons.remove_red_eye),
                        label: const Text("Ko'proq"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, dynamic value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            '${value ?? '___'}',
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
