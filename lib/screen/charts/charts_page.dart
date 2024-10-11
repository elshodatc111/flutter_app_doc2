import 'package:flutter/material.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          child: const Text(
            'Qashqadaryo viloyati IIB tomonidan qidiruvda bo’lgan fuqarolarning O’zbekiston hududida yurganlar to‘g‘risida tahliliy ma’lumot',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff1F3864),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],

            ),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(color: Color(0xff1F3864)),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(1.5),
                },
                children: const [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xffE7E7E7),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Tuman/Shahar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Rasmiy qidiruvdagilar soni',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Qidiruv bo\'lishi kutilayotganlar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Dexqonobod tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'G\'uzor tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Qamashi tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Qarshi tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Koson tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Kitob tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Mirishkor tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Muborak tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Nishon tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Kasbi tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Ko\'dala tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Chiroqchi tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Shaxrisabz tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Shaxrisabz shahar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Yakkabog\' tumani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Qarshi shahar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xffE7E7E7),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Viloyat bo\'yicha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '22',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '25',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1F3864),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
