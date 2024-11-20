
import 'package:Search/screen/child/child_page.dart';
import 'package:Search/screen/list/list_page.dart';
import 'package:Search/screen/profel/profel_page.dart';
import 'package:Search/screen/save/save_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    ListPage(),
    SavePage(),
    ChildPage(),
    const ProfelPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        width: Get.width,
        height: Get.height,
        color: Color(0xffE8E8E8),
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const[
           BottomNavigationBarItem(
             backgroundColor: Color(0xffEDD694),
            icon: Icon(Icons.search),
            label: 'Qidiruv',
            activeIcon: Icon(Icons.search),
           ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xffEDD694),
            icon: Icon(Icons.save),
            label: 'Tanlangan',
            activeIcon: Icon(Icons.save),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xffEDD694),
            icon: Icon(Icons.child_care),
            label: 'Yo\'qolganlar',
            activeIcon: Icon(Icons.child_care),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xffEDD694),
            icon: Icon(Icons.person),
            label: 'Profel',
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

