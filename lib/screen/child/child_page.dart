import 'package:flutter/material.dart';
import 'package:Search/screen/list/list_show_page.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ChildPage extends StatefulWidget {
  const ChildPage({super.key});
  @override
  State<ChildPage> createState() => _ChildPageState();
}
class _ChildPageState extends State<ChildPage> {
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
      Uri.parse('https://cyberkarshi.uz/app/public/api/child'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchResults = data['child'];
      });
    } else {
      print('Failed to load data');
    }
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
          'Yo\'qolgan shaxslar',
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
          childAspectRatio: 3 / 4,
        ),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final item = searchResults[index];
          return Card(
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
                          item['fio'] ?? 'FIO aniqlanmadi',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Text("Tug'ilgan kuni: ",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16.0),),
                          Text(item['birthday'],style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0),),
                        ],
                      ),
                      Text(item['about'],style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0),),
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

}
