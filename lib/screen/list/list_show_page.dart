import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';

class ListShowPage extends StatefulWidget {
  final String id;

  const ListShowPage({Key? key, required this.id}) : super(key: key);

  @override
  _ListShowPageState createState() => _ListShowPageState();
}

class _ListShowPageState extends State<ListShowPage> {
  late Map<String, dynamic> itemDetails;
  bool isLoading = true;
  bool isSubmitting = false;

  final GetStorage storage = GetStorage();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // FormState uchun kalit

  @override
  void initState() {
    super.initState();
    fetchItemDetails();
  }

  Future<void> fetchItemDetails() async {
    final token = storage.read('token');
    try {
      final response = await http.get(
        Uri.parse('https://qidruv.atko.tech/api/search_show/${widget.id}'),
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
        print('Failed to load data: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ma\'lumotni yuklashda xatolik: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Tarmoq xatosi: $e');
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shaxsni ko\'rinish',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
                'https://qidruv.atko.tech/photo/${itemDetails['photo']}',
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.6),
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    itemDetails['type']=='1'?"Rasmiy qidruv":"Qidruv kutilmoqda",
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
                  color: Colors.orange.withOpacity(0.6),
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    itemDetails['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
              const SizedBox(height: 20),ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Qidruvdagi shaxs haqida',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        content: Form(
                          key: _formKey, // FormState bilan ishlash
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Shaklni kichikroq qilish
                            children: [
                              // Phone number field with validator
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  labelText: 'Telefon raqamingiz',
                                  prefixText: '+998 ',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Telefon raqamini kiriting';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              // Message field
                              TextFormField(
                                controller: _messageController,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  labelText: 'Qidruvdagi shaxs haqida',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Xabarni kiriting';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: isSubmitting
                                    ? null // Disable the button while submitting
                                    : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isSubmitting = true; // Start loading
                                    });
                                    String phone = _phoneController.text;
                                    String message = _messageController.text;
                                    final token = storage.read('token');
                                    final userId = storage.read('id');
                                    final searchId = widget.id;
                                    final userIdString = userId.toString(); // Convert to String
                                    final searchIdString = searchId.toString();

                                    final body = {
                                      'search_id': searchIdString, // Convert int to String
                                      'user_id': userIdString,     // Convert int to String
                                      'text': message,
                                      'phone': phone,
                                    };

                                    try {
                                      final response = await http.post(
                                        Uri.parse('https://cyberkarshi.uz/app/public/api/search_post'),
                                        headers: {
                                          'Accept': 'application/json',
                                          'Authorization': 'Bearer $token',
                                        },
                                        body: body,
                                      );

                                      if (response.statusCode == 200) {
                                        _phoneController.clear();
                                        _messageController.clear();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Xabar muvaffaqiyatli yuborildi')),
                                        );
                                        Navigator.pop(context); // Close the dialog
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Xabarni yuborishda xatolik: ${response.statusCode}')),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Tarmoq xatosi: $e')),
                                      );
                                    } finally {
                                      setState(() {
                                        isSubmitting = false; // Stop loading
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: isSubmitting
                                    ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    strokeWidth: 2.0,
                                  ),
                                )
                                    : const Text('Xabarni yuborish',style: TextStyle(color: Colors.white),),
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.red
                ),
                child: const Text(
                  "Qidruvdagi shaxs haqida habar berish",
                  style: TextStyle(color: Colors.white),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
