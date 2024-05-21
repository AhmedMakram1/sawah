import 'package:flutter/material.dart';
import 'package:sawah_app/map.dart';

class AttractionsList extends StatelessWidget {
  final Map<String, dynamic> attractionsData;
  final List<Color> colors = [
    Colors.green,
    Colors.red,
    Colors.pink,
    Colors.blue,
    Colors.orange
  ]; // Add more colors as needed

  AttractionsList({Key? key, required this.attractionsData, required Map<String, dynamic> tripData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Enjoy Your Trip',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        children: _buildDayWiseAttractions(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<Map<String, dynamic>> attractionsList = [];
          int dayIndex = 0;
          attractionsData.forEach((day, attractions) {
            (attractions as List)
                .cast<Map<String, dynamic>>()
                .forEach((attraction) {
              attraction['color'] = colors[dayIndex % colors.length]
                  .value; // Store color value as part of attraction data
              attractionsList.add(attraction);
            });
            dayIndex++;
          });

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapPage(
                      attractions: attractionsList,
                    )),
          );
        },

        child: Icon(Icons.map), // Changed icon to map for relevance
      ),
    );
  }

  List<Widget> _buildDayWiseAttractions(BuildContext context) {
    List<Widget> dayWiseAttractions = [];
    int dayIndex = 0;
    attractionsData.forEach((day, attractionsList) {
      List<Widget> attractionWidgets = [];

      List<dynamic> attractions = attractionsList as List<dynamic>;

      for (var attraction in attractions) {
        final Map<String, dynamic> attractionData =
            attraction as Map<String, dynamic>;

        // Skip adding the description if it contains 'Anything'
        String description = attractionData['Description'];
        if (description == 'Anything') {
          description = '';
        }

        // Generate star list for ratings
        List<Widget> stars = List.generate(5, (index) {
          return Icon(
            index < attractionData['Rating'] ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 20.0,
          );
        });

        attractionWidgets.add(
          Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (attractionData['Photo_link'] != null)
                  Image.network(
                    attractionData['Photo_link'],
                    width: double.infinity, // Take the full width of the card
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ListTile(
                  title: Text(attractionData['Attraction_Name']),
                  subtitle: Text(description),
                ),
                Card(
                  // ... other card properties
                  child: Column(
                    children: [
                      // ... Image.network and ListTile
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Combined rating number and stars in a single row
                            Row(
                              children: [
                                Text('${attractionData['Rating']} '),
                                Row(children: stars),
                              ],
                            ),
                            Text('${attractionData['Duration (hours)']} hrs'),
                            Text('${attractionData['Admission_Price']} \$'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }

      dayWiseAttractions.add(
        ExpansionTile(
          leading: Icon(Icons.location_on,
              color: colors[
                  dayIndex % colors.length]), // Rotate through the color list
          title: Text(day),
          children: attractionWidgets,
        ),
      );
      dayIndex++;
    });

    return dayWiseAttractions;
  }
}
