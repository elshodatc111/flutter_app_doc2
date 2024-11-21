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
    try {
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
        print('Failed to load data: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ma\'lumotni yuklashda xatolik: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Tarmoq xatosi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarmoq bilan muammo. Internetni tekshiring.')),
      );
    }
  }

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
                  onPressed: _sendReport,
                  child: const Text('Xabarni yuborish'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _sendReport() async {
    final phoneNumber = _phoneController.text.trim();
    final message = _messageController.text.trim();
    final token = storage.read('token');
    final id = storage.read('id');
    final searchId = widget.id;

    if (phoneNumber.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Iltimos, barcha maydonlarni to\'ldiring.')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://cyberkarshi.uz/app/public/api/search_post'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'search_id': searchId,
          'phone_number': phoneNumber,
          'user_id': id,
          'message': message,
        }),
      );

      Navigator.pop(context); // Close the dialog

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Xabar muvaffaqiyatli yuborildi!')),
        );
      } else {
        print('Xato javob: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xatolik yuz berdi: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('POST yuborishda xatolik: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarmoq bilan muammo. Iltimos, qayta urinib ko\'ring.')),
      );
    }
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
                onPressed: _showReportDialog,
                child: const Text("Qidruvdagi shaxs haqida habar berish"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
