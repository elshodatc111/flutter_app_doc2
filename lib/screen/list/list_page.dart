import 'package:Search/screen/list/list_show_page.dart';
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
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2 / 3,
        ),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final item = searchResults[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20.0),
            elevation: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Image.network(
                        'https://cyberkarshi.uz/app/public/photo/${item['photo']}',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 50),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          color: Colors.red.withOpacity(0.6),
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            item['type'] == "1" ? "Rasmiy qidiruv" : "Qidruv kutilmoqda",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.6),
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            item['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          item['fio'] ?? 'No FIO',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildInfoRow('JK moddasi:', item['substance']),
                      _buildInfoRow('Hudud:', item['adress']),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        List<Map<String, dynamic>> savedData = [];
                        for (var item in searchResults) {
                          Map<String, dynamic> itemData = {
                            'id': item['id'],
                            'name': item['name'],
                            'fio': item['fio'],
                            'substance': item['substance'],
                            'address': item['address'],
                            'photo': item['photo'],
                            'type': item['type'],
                          };
                          savedData.add(itemData);
                        }
                        await storage.write('savedSearchData', savedData);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Ma\'lumotlar saqlandi!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.save, color: Colors.white),
                          Text(" Saqlash", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    )
                    ,
                    ElevatedButton(
                      onPressed: () => navigateToListShowPage(item['id'].toString()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child:const Row(
                        children: [
                          Icon(Icons.remove_red_eye, color: Colors.white),
                          Text(" Ko'proq",style:  TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper method to build info rows
  Widget _buildInfoRow(String label, dynamic value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          '${value ?? '___'}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
