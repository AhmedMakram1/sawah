import 'package:flutter/material.dart';

class Beach {
  final String name;
  final String imageUrl;

  Beach(this.name, this.imageUrl);
}

class BeachPage extends StatelessWidget {
  final List<Beach> Beachs = [
    Beach('Abu Debbab beach', 'assets/images/abu debbab beach.jpg'),
    Beach('blue-lagoon', 'assets/images/blue-lagoon.jpg'),
    Beach('gebel-el-rosas', 'assets/images/gebel-el-rosas.jpg'),
    Beach('khaleg almaza', 'assets/images/khaleg almaza.jpg'),
    Beach('khaleg nama', 'assets/images/khaleg nama.jpg'),
    Beach('mangrove beach', 'assets/images/mangrove beach.jpg'),
    Beach('marsa shoona bay', 'assets/images/marsa shoona bay.jpg'),
    Beach('marsa-mubarak', 'assets/images/marsa-mubarak.jpg'),
    Beach('ras-um-sid', 'assets/images/ras-um-sid-view-from.jpg'),
    Beach('shark-s-bay-beach', 'assets/images/shark-s-bay-beach.jpg'),
    Beach('sharm elolle', 'assets/images/sharm elolle.jpg'),
    Beach('zeytouna-beach', 'assets/images/zeytouna-beach.jpg'),
    Beach('zouni beach club', 'assets/images/zouni beach club.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Beachs in Egypt',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: Beachs.map((Beach) {
          return GestureDetector(
            onTap: () {
              // Handle the tap event here
              print('You tapped on ${Beach.name}');
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Beach.imageUrl, height: 100),
                  Text(Beach.name),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
