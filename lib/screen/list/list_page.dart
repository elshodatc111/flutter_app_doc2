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

  // Fetch the search data from the API
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

  // Save the selected item to local storage
  void saveDataToStorage(Map<String, dynamic> item) {
    storage.write('saved_item', item);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Xotiraga saqlandi')),
    );
  }

  // Navigate to the ListShowPage and pass the id
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
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xffECD593),
      ),
      body: searchResults.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 9 / 16,
        ),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final item = searchResults[index];

          return Card(
            elevation: 2,
            child: Column(
              children: [
                // Image and overlay labels
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
                // Information section
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
                      _buildInfoRow('QYJ:', item['qyj']),
                      _buildInfoRow('Tug\'ilganun kun:', item['birthday']),
                      _buildInfoRow('Hudud:', item['adress']),
                    ],
                  ),
                ),
                // Save and View buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => saveDataToStorage(item),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Icon(Icons.save, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () => navigateToListShowPage(item['id'].toString()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Icon(Icons.remove_red_eye, color: Colors.white),
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
