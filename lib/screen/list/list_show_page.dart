import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';

class ListShowPage extends StatefulWidget {
  final String id; // Receive the id passed from ListPage

  const ListShowPage({super.key, required this.id});

  @override
  _ListShowPageState createState() => _ListShowPageState();
}

class _ListShowPageState extends State<ListShowPage> {
  late Map<String, dynamic> itemDetails;
  bool isLoading = true;
  final GetStorage storage = GetStorage();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchItemDetails();
  }

  Future<void> fetchItemDetails() async {
    final token = storage.read('token');
    final response = await http.get(
      Uri.parse('https://cyberkarshi.uz/app/public/api/search_show/${widget.id}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        itemDetails = data['search'];
        isLoading = false;
      });
    } else {
      print('Failed to load data');
    }
  }

  // Function to show the dialog
  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Qidruvdagi shaxs haqida'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Telefon raqam',
                    prefixText: '+998 ',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Restrict the format to +998 99 999 9999
                      String newText = newValue.text;
                      return TextEditingValue(
                        text: newText,
                        selection: TextSelection.collapsed(offset: newText.length),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _messageController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Qidruvdagi shaxs haqida',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final phoneNumber = _phoneController.text;
                    final message = _messageController.text;

                    // Get the ID and token
                    final token = storage.read('token');
                    final id = storage.read('id');
                    final searchId = widget.id;

                    // Sending the POST request
                    final response = await http.post(
                      Uri.parse('https://cyberkarshi.uz/app/public/api/search_post'),
                      headers: {
                        'Authorization': 'Bearer $token',
                      },
                      body: {
                        'search_id': searchId,
                        'phone_number': phoneNumber,
                        'user_id': id,
                        'message': message,
                      },
                    );

                    if (response.statusCode == 200) {
                      // If request is successful
                      Navigator.pop(context); // Close the dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Xabar muvaffaqiyatli yuborildi!')),
                      );
                    } else {
                      // If request fails
                      Navigator.pop(context); // Close the dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Xatolik yuz berdi. Iltimos, qaytadan urunib ko\'ring.')),
                      );
                    }
                  },
                  child: const Text('Xabarni yuborish'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shaxsni ko\'rinish',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xffECD593),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://cyberkarshi.uz/app/public/photo/${itemDetails['photo']}',
                width: double.infinity,
                height: 500,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                'F.I.O: ${itemDetails['fio']?.toString() ?? '___'}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'JK moddasi: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(itemDetails['substance']?.toString() ?? '___'),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'QYJ: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(itemDetails['qyj']?.toString() ?? '___'),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Tug\'ilgan kun: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(itemDetails['birthday']?.toString() ?? '___'),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Hudud: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(itemDetails['adress']?.toString() ?? '___'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showReportDialog, // Show the dialog when pressed
                child: const Text("Qidruvdagi shaxs haqida habar berish"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
