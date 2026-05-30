import 'package:flutter/material.dart';
import 'home_page.dart';
import 'page2.dart';
import 'page3.dart';
import 'page5.dart';
import 'api_demo_page.dart'; 

class NavigasiUtama extends StatefulWidget {
  const NavigasiUtama({super.key});

  @override
  State<NavigasiUtama> createState() => _NavigasiUtamaState();
}

class _NavigasiUtamaState extends State<NavigasiUtama> {
  int _selectedIndex = 0;

  
  final List<Widget> _pages = [ 
    const HomePage(),
    const Page2(),
    const Page3(),   
    const MyApp(),             
    const ApiDemoPage(),  
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF003566), 
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        // Daftar item navigasi 
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'PBB',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_filled_outlined),
            label: 'Kendaraan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_outlined),
            label: 'Keliling',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_queue),
            activeIcon: Icon(Icons.cloud),
            label: 'API Demo',
          ),
        ],
      ),
    );
  }
}