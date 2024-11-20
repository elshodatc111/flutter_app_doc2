import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  List<dynamic> savedItems = [];

  @override
  void initState() {
    super.initState();
    loadSavedItems();
  }

  // Load saved items from GetStorage
  void loadSavedItems() async {
    // Ensure GetStorage is initialized
    await GetStorage.init();

    // Load saved data
    final savedData = GetStorage().read('saved_items') ?? [];

    if (savedData is List) {
      setState(() {
        savedItems = savedData;
      });
    } else {
      // If data is not a List, handle appropriately
      setState(() {
        savedItems = [];
      });
    }
  }

  // Delete item from GetStorage
  void deleteItem(Map<String, dynamic> itemToDelete) {
    List<dynamic> updatedList = savedItems.where((item) => item != itemToDelete).toList();
    GetStorage().write('saved_items', updatedList);
    setState(() {
      savedItems = updatedList;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Items'),
        backgroundColor: const Color(0xffECD593),
      ),
      body: savedItems.isEmpty
          ? const Center(child: Text('No saved items yet.'))
          : ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          final item = savedItems[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Full Image at the top
                Image.network(
                  'https://cyberkarshi.uz/app/public/photo/${item['photo']}',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(item['fio'] ?? 'No FIO'),
                    subtitle: Text(item['adress'] ?? 'No Address'),
                  ),
                ),
                // Show and Delete Buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Delete Button
                      ElevatedButton(
                        onPressed: () => deleteItem(item),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      // Show Button (customize this further)
                      ElevatedButton(
                        onPressed: () {
                          // Show details or any other action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Show',
                          style: TextStyle(color: Colors.white, fontSize: 12),
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
}
