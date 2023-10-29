import 'package:flutter/material.dart';

import 'FavoriEtkinlikler.dart';
import 'Profil.dart';

import 'anasayfa.dart';

class TapBarController extends StatefulWidget {  @override
State<TapBarController> createState() => _TapBarControllerState();
}

class _TapBarControllerState extends State<TapBarController> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    final screens = [Anasayfa(),Favorilerim(),Profil()];
    return Scaffold(

        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value){
            setState(() {
              selectedIndex=value;
            });
          },
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.black,
          items: [
            _customButtonNavigationBarItem(Icons.house,"Anasayfa"),
            _customButtonNavigationBarItem(Icons.favorite,"Favori Etkinlikler"),
            _customButtonNavigationBarItem(Icons.person,"Profil"),
          ],
        ));
  }
  BottomNavigationBarItem _customButtonNavigationBarItem(
      IconData iconData,String label) =>BottomNavigationBarItem(icon:Icon(iconData),label: label
  );
}


