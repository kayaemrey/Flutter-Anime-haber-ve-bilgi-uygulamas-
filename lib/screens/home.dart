import 'package:animetab/screens/anasayfa.dart';
import 'package:animetab/screens/arama.dart';
import 'package:animetab/screens/topList.dart';
import 'package:flutter/material.dart';


class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final tabs = [
    toplistpage(),
    anasayfapage(),
    aramapage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny,color: Colors.black87,),
              label: 'Top list',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome_motion,color: Colors.black87,),
              label: 'Haberler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,color: Colors.black87,),
              label: 'Arama',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black87,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: tabs.elementAt(_selectedIndex),
        ),
      ),
    );
  }

}
