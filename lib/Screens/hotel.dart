import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class HotelPage extends StatefulWidget {
  @override
  _HotelSearchPageState createState() => _HotelSearchPageState();
}

class _HotelSearchPageState extends State<HotelPage> {
  final TextEditingController _destinationController = TextEditingController();
  List<dynamic> _hotels = [];

  Future<void> _searchHotels() async {
    var response = await http.post(
      Uri.parse(
          'http://192.168.1.6:5000/recommend_hotels'), // Replace with your API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'destination': _destinationController.text,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _hotels = jsonDecode(response.body);
      });
    } else {
      // Handle errors or no results
    }
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    print(
        'Hotel URL: ${hotel['Hotel_link']}'); // Add this line to debug the URL
    return Card(
      child: Column(
        children: [
          Image.network(
              hotel['Image_link'] ??
                  'https://via.placeholder.com/150', // Provide a default image link if null
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover),
          ListTile(
            title: Text(hotel['Hotel_ Name']), // Provide a default name if null
            subtitle:
                Text(hotel['Address']), // Provide a default address if null
            isThreeLine: true,
          ),
          ButtonBar(
            children: [
              Text(
                  'Rate: ${hotel['Rate']}'), // Provide a default rating if null
              TextButton(
                onPressed: hotel['Hotel_link'] != null
                    ? () => _launchURL(hotel['Hotel_link'])
                    : null, // Disable button if link is null
                child: Text('Visit Hotel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void _launchURL(String url) async {
    try {
      await FlutterWebBrowser.openWebPage(url: url);
    } catch (e) {
      print('Failed to launch URL: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Hotel Search',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                hintText: 'Enter Destination',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchHotels,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _hotels.length,
              itemBuilder: (context, index) {
                return _buildHotelCard(_hotels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
