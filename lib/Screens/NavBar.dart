import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:sawah_app/Screens/HomeScreen.dart';
import 'ProfilePage.dart';
import 'explore.dart';

class MyNevBar extends StatefulWidget {
  @override
  _MyNevBarState createState() => _MyNevBarState();
}

class _MyNevBarState extends State<MyNevBar> {
  int currentIndex = 0;

  List listOfColors = [HomeScreen(), ExplorePage(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfColors[currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Color(0xff385f98)),
          BottomNavyBarItem(
              icon: Icon(Icons.explore),
              title: Text('Explore'),
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Color(0xff385f98)),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Color(0xff385f98)),
        ],
      ),
    );
  }
}
