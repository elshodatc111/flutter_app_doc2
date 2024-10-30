import 'package:Search/screen/charts/charts_page.dart';
import 'package:Search/screen/list/list_page.dart';
import 'package:Search/screen/login/login_page.dart';
import 'package:Search/screen/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    ChartsPage(),
    ListPage(),
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
            icon: Icon(Icons.bar_chart,color: Colors.grey,),
            label: 'STATISTIKA',
            activeIcon: Icon(Icons.bar_chart,color: Color(0xff8FAADC),),
          ),
           BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.people,color: Colors.grey,),
            label: 'RO\'YXAT',
            activeIcon: Icon(Icons.people,color: Color(0xff8FAADC),),
          ),
        ],
      ),
    );
  }
}

