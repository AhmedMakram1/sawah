import 'package:flutter/material.dart';

class Museum {
  final String name;
  final String imageUrl;

  Museum(this.name, this.imageUrl);
}

class MuseumPage extends StatelessWidget {
  final List<Museum> museums = [
    Museum('Abdeen Palace Museums', 'assets/images/Abdeen Palace Museums.jpg'),
    Museum('Alexandria', 'assets/images/Alexandria.jpg'),
    Museum('ata bazar', 'assets/images/ata bazar.jpg'),
    Museum('Coptic Museum', 'assets/images/Coptic Museum.jpg'),
    Museum('interior-of-the-mummification',
        'assets/images/interior-of-the-mummification.jpg'),
    Museum('karnak-holly-temple', 'assets/images/karnak-holly-temple.jpg'),
    Museum('king tut', 'assets/images/king tut.jpg'),
    Museum('luxor', 'assets/images/luxor.jpg'),
    Museum('nubian-museum', 'assets/images/nubian-museum.jpg'),
    Museum('Royal Jewelery Museum', 'assets/images/Royal Jewelery Museum.jpg'),
    Museum('the-giza-pyramids-now', 'assets/images/the-giza-pyramids-now.jpg'),
    Museum('the-museum-landscape', 'assets/images/the-museum-landscape.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Museums in Egypt',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: museums.map((museum) {
          return GestureDetector(
            onTap: () {
              // Handle the tap event here
              print('You tapped on ${museum.name}');
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(museum.imageUrl, height: 100),
                  Text(museum.name),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
