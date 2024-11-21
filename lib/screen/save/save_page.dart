import 'package:Search/screen/list/list_show_page.dart';
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
  void loadSavedItems() async {
    await GetStorage.init();
    final savedData = GetStorage().read('savedSearchData') ?? [];
    if (savedData is List) {
      setState(() {
        savedItems = savedData;
      });
    } else {
      setState(() {
        savedItems = [];
      });
    }
  }

  void deleteItem(Map<String, dynamic> itemToDelete) {
    List<dynamic> updatedList = savedItems.where((item) => item != itemToDelete).toList();
    GetStorage().write('savedSearchData', updatedList);
    setState(() {
      savedItems = updatedList;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('O\'chirildi')),
    );
  }

  void navigateToListShowPage(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListShowPage(id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saqlanganlar',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xffECD593),
      ),
      body: savedItems.isEmpty
          ? const Center(child: Text('Saqlanganlar mavjud emas'))
          : ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          final item = savedItems[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(
                  'https://cyberkarshi.uz/app/public/photo/${item['photo']}',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(item['fio'] ?? 'No FIO', style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20),textAlign: TextAlign.center,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => deleteItem(item),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.delete_forever_outlined,color: Colors.white,),
                            Text(" O'chirish",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: ()=> navigateToListShowPage(item['id'].toString()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.remove_red_eye,color: Colors.white,),
                            Text(" Batafsil",style: TextStyle(color: Colors.white),)
                          ],
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
