import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawah_app/Screens/beach.dart';
import 'package:sawah_app/Screens/cities.dart';
import 'package:sawah_app/Screens/hotel.dart';
import 'package:sawah_app/Screens/museum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sawah_app/attraction.dart';
import 'package:sawah_app/plan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<HomeScreen> {
  final Map<String, String> cityImages = {
    'Cairo': 'assets/images/cairo.jpg',
    'Luxor': 'assets/images/louxor.jpg',
    'Aswan': 'assets/images/aswan_dam.jpg',
    'Hurghada': 'assets/images/hurghada.jpg',
    'Alexandria': 'assets/images/Alexandria.jpg',
    'Sharm ElSheikh': 'assets/images/Port Said.JPG',
    // Add more cities and their corresponding images as needed
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPlan()),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            _buildHeader(),
            _buildIconsGrid(),
            _buildTripCards(), // Include the Firestore trip cards here
            const SizedBox(height: 10), // Some spacing
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Image.asset(
              "assets/images/muizz_street.jpg",
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
        Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(35.0),
              child: Text(
                "Trip planner in Egypt",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
            Text(
              "Explore The best Place In Egypt",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  Widget _buildIconsGrid() {
    return SizedBox(
      height: 130,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(17.0),
          child: GridView(
            physics: AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisExtent: 90,
            ),
            children: [
              Card(
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CitiesPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black38, blurRadius: 4)
                        ],
                      ),
                      child: Image.asset("assets/images/city.png",
                          width: 60, height: 60),
                    ),
                  ),
                  const Text("Cities"),
                ]),
              ),
              Card(
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BeachPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.8),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 4)
                        ],
                      ),
                      child: Image.asset("assets/images/beach.png",
                          width: 60, height: 60),
                    ),
                  ),
                  SizedBox(height: 20, child: Text("Beach")),
                ]),
              ),
              Card(
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HotelPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.8),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 4)
                        ],
                      ),
                      child: Image.asset("assets/images/hotel.png",
                          width: 60, height: 60),
                    ),
                  ),
                  SizedBox(height: 20, child: Text("Hotel")),
                ]),
              ),
              Card(
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.8),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.black38, blurRadius: 4)
                      ],
                    ),
                    child: Image.asset("assets/images/mountain.png",
                        width: 60, height: 60),
                  ),
                  SizedBox(height: 20, child: Text("Mountain")),
                ]),
              ),
              Card(
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MuseumPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.8),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black38, blurRadius: 4)
                        ],
                      ),
                      child: Image.asset("assets/images/museum.png",
                          width: 60, height: 60),
                    ),
                  ),
                  SizedBox(height: 20, child: const Text("Museum")),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripCards() {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Center(child: Text("No user logged in"));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('trips')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Trips",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var tripDoc = snapshot.data!.docs[index];
                  var tripData = tripDoc['input'];
                  var destination = tripData['Destination'] ?? 'Unknown';

                  // Get the image for the destination
                  var image =
                      cityImages[destination] ?? 'assets/images/unknown.jpg';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttractionsList(
                            attractionsData: tripDoc['output'],
                            tripData: tripData,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(destination),
                            subtitle:
                                Text('${tripData['Duration (days)']} days'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTrip(tripDoc.id),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create your first trip",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: Icon(Icons.add_circle,
                      size: 50, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewPlan()),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void _deleteTrip(String docId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No user logged in"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('trips')
          .doc(docId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Trip deleted successfully"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete trip: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _iconCard(String image, String label, VoidCallback onTap) {
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black38, blurRadius: 4)
                ],
              ),
              child: Image.asset("assets/images/$image", width: 60, height: 60),
            ),
          ),
          SizedBox(height: 20, child: Text(label)),
        ],
      ),
    );
  }
}
