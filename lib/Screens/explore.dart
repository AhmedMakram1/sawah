import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExplorePage extends StatelessWidget {
  final List<Tour> tours = [
    Tour(
        title: "Private tour: Giza Pyramids, Memphis...",
        description:
            "Explore the ancient wonders of Egypt on a captivating private tour designed to inspire and enrich. Our expert guide will...",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fmedia-cdn.tripadvisor.com%2Fmedia%2Fattractions-splice-spp-720x480%2F0b%2Ff9%2Ffd%2F66.jpg&w=640&q=75",
        bookNowUrl:
            "https://www.viator.com/tours/Cairo/Guided-Half-Day-Trip-to-Giza-Pyramids-with-Camel-Riding/d782-10449P75?mcid=42383&pid=P00104500&medium=api&api_version=2.0&campaign=tripidecf687db-49fc-456c-923b-df1252953550&campaign=interesting-tours-section~1ffe8b0d-ab2d-4f20-ae88-69a9684b799d"),
    Tour(
        title: "4-Day 3-Night Nile Cruise from...",
        description:
            "Experience the magic of the Nile with our 3 nights Nile cruise, meals, expert tour guide, qualified licensed drivers, door to...",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fmedia-cdn.tripadvisor.com%2Fmedia%2Fattractions-splice-spp-720x480%2F0b%2Ff9%2Ffd%2F66.jpg&w=640&q=75",
        bookNowUrl: "https://www.google.com/"),
    Tour(
        title: "Alexandria Day Trip From Cairo",
        description:
            "See the Library of Alexandria, St. Mark's oldest church, the Roman amphitheater, and the quaint Montaza Gardens...",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fmedia-cdn.tripadvisor.com%2Fmedia%2Fattractions-splice-spp-720x480%2F0b%2Ff9%2Ffd%2F66.jpg&w=640&q=75",
        bookNowUrl: "https://www.youtube.com/"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Explore',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: tours.length,
        itemBuilder: (context, index) {
          final tour = tours[index];
          return TourCard(tour: tour);
        },
      ),
    );
  }
}

class Tour {
  final String title;
  final String description;
  final String imageUrl;
  final String bookNowUrl;

  Tour({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.bookNowUrl,
  });
}

class TourCard extends StatelessWidget {
  final Tour tour;

  TourCard({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              tour.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              tour.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              tour.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                // Navigate to the book now URL
                _launchURL();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Book now"),
                  Icon(Icons.arrow_right_alt),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const bookNowUrl =
        'https://www.viator.com/tours/Cairo/Guided-Half-Day-Trip-to-Giza-Pyramids-with-Camel-Riding/d782-10449P75?mcid=42383&pid=P00104500&medium=api&api_version=2.0&campaign=tripidecf687db-49fc-456c-923b-df1252953550&campaign=interesting-tours-section~1ffe8b0d-ab2d-4f20-ae88-69a9684b799d';
    if (await launch(bookNowUrl)) {
      await canLaunch(bookNowUrl);
    } else {
      throw 'Could not launch $bookNowUrl';
    }
  }
}
