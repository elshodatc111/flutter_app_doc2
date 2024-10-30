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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: searchResults.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchSearchData, // Trigger fetchSearchData on pull-down
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final item = searchResults[index];
            return Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue.shade200, width: 1.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://cyberkarshi.uz/app/public/photo/${item['photo']}',
                        width: 90, // 3x4 aspect ratio with a larger image
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['type'] == '1' ? 'rasmiy qidiruv' : 'kutilayotgan qidiruv',
                            style: TextStyle(color: item['type'] == '1' ? Colors.red : Colors.green,fontWeight: FontWeight.bold,),
                          ),
                          Text("${item['fio'] ?? 'No Name'}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          const SizedBox(height: 4.0),
                          Text("Tug'ilgan kuni: ${item['birthday'] ?? 'not fount'}"),
                          Text("Manzili: ${item['adress'] ?? 'not found'}"),
                          Text("JK moddasi: ${item['substance'] ?? 'not fount'}"),
                          Text("QYJ vaqti: ${item['qyj'] ?? ''}"),
                          const SizedBox(height: 4.0),
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
