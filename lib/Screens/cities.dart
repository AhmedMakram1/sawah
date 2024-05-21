import 'package:flutter/material.dart';

class City {
  final String name;
  final String imageUrl;
  final String description; // Add description field

  City(this.name, this.imageUrl, this.description);
}

class CitiesPage extends StatelessWidget {
  final List<City> cities = [
    City('Cairo', 'assets/images/cairo.jpg',
        '(al Qahirah) is the capital of the Arab Republic of Egypt and its largest and most important city of all. It is the largest Arab city in terms of population and area, and occupies second place in Africa and seventeenth in the world in terms of population, with a population of 21,322,750 million people according to 2021 statistics. They represent 20% of The total population of Egypt is more than (100 million people)'),
    City('Aswan', 'assets/images/aswan_dam.jpg',
        ' located in southern Egypt, is considered one of the most important governorates in the Egyptian Republic, as it is famous for its distinguished location on the banks of the Nile River, the stunning views it enjoys, and the distinctive archaeological sites located on its land, in addition to its warm climate and distinctive botanical islands.'),
    City('Alexandria', 'assets/images/alex.jpg',
        'is one of Egypt governorates and the second capital after Cairo, and it is the first port of the Arab Republic of Egypt. It is located in the north of the country on the Mediterranean coast. It includes three cities: Alexandria, which is the administrative capital, and its largest city, New Burj Al Arab.'),
    City('Louxor', 'assets/images/luxor_temple.jpg',
        'is an Egyptian governorate located in the southern Upper Egypt region. Its centers and cities are distributed on both banks of the Nile River. Its capital is the city of Luxor, which in ancient times represented the city of Thebes, the capital of Egypt during several Pharaonic eras.'),
    City('Sinai', 'assets/images/Sinai.jpg',
        'which has an area of about 27,327 thousand km2 and an estimated population of 486,242 thousand people for the year 2021 AD. - North Sinai, Bakr Governorate, is free of any manifestations of pollution and enjoys an infrastructure supportive of investment and distinct incentives and guarantees from the rest of the valley governorates.'),
    City('Suez', 'assets/images/Suez.jpg',
        'its coast is located on the northern end of the Gulf of Suez, and the southern entrance to the Suez Canal is located in it, and its area is 9002 km2. It is an urban governorate with one city. It is distinguished by its unique location, as it is considered a gateway to Africa and the countries of Southwest and East Asia, making it a forum for global trade and a citadel of industry and industrial investment.'),
    City('Qena', 'assets/images/Qena.jpg',
        'is considered one of the South Valley governorates in the Arab Republic of Egypt, which has a significant amount of the basic and necessary components necessary for economic and social development, as it contains mining wealth, agricultural crops, reclaimable lands, and many tourist sites and monuments, in addition to the availability of manpower in various specializations.'),
    City('Beheira', 'assets/images/Beheira.jpg',
        'is one of the governorates of Egypt, and its capital, Damanhour, is located in the west of the Delta and its north is the Mediterranean Sea, in the east it is the Rosetta Branch, in the west it is Alexandria Governorate and Matrouh Governorate, and in the south it is Giza Governorate, and the religious reformer Muhammad Abduh grew up there.'),
    City('Dakahlia', 'assets/images/Dakahlia.webp',
        ' is located on both sides of the Damietta branch in the north-east of the Nile Delta. It is in the shape of a triangle with its apex in the south and its base in the north, where the Mediterranean Sea and Lake Manzala are. It is bordered to the west by Kafr El-Sheikh and Gharbia governorates, and to the east by Sharkia governorate.'),
    City('Faiyum', 'assets/images/Faiyum.jpg',
        ' is located in the Western Desert, southwest of Cairo Governorate. It is one of the governorates of North Upper Egypt and is connected to Beni Suef from the southeast, at a distance of 45 km, and is bordered by Giza Governorate, at a distance of 85 km.'),
    City('Gharbia', 'assets/images/Gharbia',
        'is an Egyptian governorate, and it is the capital of the Delta region. It is located in the heart of the Nile River Delta between the delta governorates between the Damietta and Rasheed branches. It is bordered to the north by Kafr El-Sheikh Governorate, to the south by Menoufia Governorate, to the east by Qalyubia and Dakahlia Governorates, and to the west by Beheira Governorate, making it a meeting place for many cultures. National and subsidiary and a center for many industries.'),
    City('Ismailia', 'assets/images/Ismailia.png',
        'is located in its western part on the continent of Africa, and its eastern part in the continent of Asia. It is bordered to the east by Sinai and the Suez Canal, to the west by Sharkia Governorate, to the south by Suez Governorate, and to the north by Port Said and Lake Manzala. Its origins go back to the pre-dynastic era.'),
    City('Kafr El Sheikh', 'assets/images/Kafr El Sheikh.jpg',
        'is one of the largest governorates in the Delta region in terms of area. It was named Kafr El-Sheikh after the one who knows God, Sheikh Talha Abi Saeed. Kafr El-Sheikh Governorate is considered an agricultural governorate. The area of agricultural land is estimated at about 554,237 acres. It is famous for producing rice, beets, wheat, and cotton.'),
    City('Matrouh', 'assets/images/Matrouh.jpg',
        'is located on the coast of the Mediterranean Sea. In the Pharaonic era, it was called the bean storehouse, because it was crowded with people and activities. Part of Matrouh shares borders with Libya. The city is considered a market and distribution center for the surrounding agricultural region. It is also famous for growing olives, barley, and fruits. Goats and sheep are raised there.'),
    City('Minya', 'assets/images/Minya.jpg',
        'It is one of the most important governorates of Upper Egypt due to its central location and the unique archaeological sites it contains. It is famous as the beautiful bride of Upper Egypt.'),
    City('Monufia', 'assets/images/Monufia.jpg',
        'is an Egyptian governorate located north of the capital, Cairo, in the south of the Nile Delta. Its capital is the city of Shebin El-Kom. The main economic activity of the governorate residents is agriculture, because the ancient lands of Menoufia between the two branches of the Nile are characterized by fertile soil and a constant abundance of irrigation water from the Nile River.'),
    City('New Valley', 'assets/images/New Valley.jpg',
        'is characterized by a dry climate in summer and warm winters, and rain is rare. The governorate is characterized by the highest percentage of sunshine in the world throughout the year, which can be exploited as a source of renewable energy. The governorate is distinguished by the presence of antiquities representing all historical eras, including Pharaonic, Roman, Coptic, Islamic, Persian, and Ptolemaic.'),
    City('Port Said', 'assets/images/Port Said.JPG',
        'is located in the northeast of Egypt, where the Mediterranean Sea meets the Suez Canal. It is bordered to the north by the Mediterranean Sea, to the east by the city of Port Fouad located in the Sinai Peninsula, to the south by Ismailia Governorate, and to the west by three governorates of Damietta (from the northwest), Dakahlia (from the west), and Sharqiya ( from the southwest).'),
    City('Red Sea', 'assets/images/Red Sea',
        ' is a coastal governorate in western Egypt. Its capital is Hurghada. The governorate constitutes about ⅛ of the area of Egypt. The coast of the Red Sea governorate is 1,080 km long, and is known to have diving centers considered among the best in the world, as well as many resorts and tourist villages, the most famous of which is El Gouna.')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Cities in Egypt',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: cities.map((city) {
          return GestureDetector(
            onTap: () {
              // Show dialog when city card is tapped
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(city.name),
                    content: Text(city.description),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(city.imageUrl, height: 100),
                  Text(city.name),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
