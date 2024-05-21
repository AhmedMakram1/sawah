import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sawah_app/attraction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MaterialApp(
    title: 'SAWAH Guide',
    home: NewPlan(),
  ));
}

class NewPlan extends StatefulWidget {
  @override
  _NewPlanState createState() => _NewPlanState();
}

class _NewPlanState extends State<NewPlan> {
  TextEditingController _durationController = TextEditingController();

  List<String> cities = [
    'Cairo',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Alexandria',
    'Sharm ElSheikh',
  ]; // Define your list of cities here

  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Welcome To SAWAH Guide',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: selectedCity,
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select a City',
                ),
                items: cities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
              ),
              SizedBox(height: 100),
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'How long will you spend? (in days)',
                ),
              ),
              SizedBox(height: 300),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedCity != null &&
                        _durationController.text.isNotEmpty) {
                      // Create a TextEditingController for the selected city
                      TextEditingController destinationController =
                          TextEditingController(text: selectedCity);

                      // Pass destinationController and _durationController to SecondPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondPage(
                            destinationController: destinationController,
                            durationController: _durationController,
                          ),
                        ),
                      );
                    } else {
                      // Show error message if city or duration is not selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Please select a city and enter duration.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final TextEditingController destinationController;
  final TextEditingController durationController;

  SecondPage({
    required this.destinationController,
    required this.durationController,
  });

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String? selectedActivity;
  double budgetValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Welcome To SAWAH Guide',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose your Activity'),
            SizedBox(height: 26),
            Wrap(
              children: [
                _buildActivityButton('Kid Friendly'),
                _buildActivityButton('Historical'),
                _buildActivityButton('Outdoors'),
                _buildActivityButton('Art Culture'),
              ],
            ),
            SizedBox(height: 32),
            Text('Budget level'),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Low'),
                Text('Medium'),
                Text('High'),
              ],
            ),
            Slider(
              value: budgetValue,
              onChanged: (value) {
                setState(() {
                  budgetValue = value;
                });
              },
              min: 0.0,
              max: 2.0,
              divisions: 2,
              label: _getBudgetLabel(budgetValue),
            ),
            SizedBox(height: 100),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _createNewTrip(context);
                },
                child: Text('Create New Trip', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityButton(String activity) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedActivity = activity;
          });
        },
        child: Text(activity),
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedActivity == activity ? Colors.green : null,
        ),
      ),
    );
  }

  String _getBudgetLabel(double value) {
    if (value == 0.0) {
      return 'Low';
    } else if (value == 1.0) {
      return 'Medium';
    } else {
      return 'High';
    }
  }

    Future<void> _createNewTrip(BuildContext context) async {
        final url = Uri.parse('http://192.168.1.6:5000/get_attractions');
        final Map<String, dynamic> tripData = {
            'Destination': widget.destinationController.text,
            'Duration (days)': int.tryParse(widget.durationController.text),
            'Activity Preference': selectedActivity ?? '',
            'Budget Range': _getBudgetLabel(budgetValue),
        };

        final jsonData = json.encode(tripData);
        final userId = FirebaseAuth.instance.currentUser?.uid;

        try {
            final response = await http.post(
                url,
                headers: {'Content-Type': 'application/json'},
                body: jsonData,
            );

            final responseData = json.decode(response.body);
            if (responseData is Map<String, dynamic>) {
                final documentReference = FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('trips')
                    .doc();

                await documentReference.set({
                    'input': tripData,
                    'output': responseData,
                });

                if (mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AttractionsList(
                                attractionsData: responseData,
                                tripData: tripData,
                            ),
                        ),
                    );
                }
            } else {
                _showDialog('Invalid Response', 'The response from the server is invalid.');
            }
        } catch (error) {
            _showDialog('Error', 'An error occurred: $error');
            FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('trips')
                .doc()
                .set({
                    'input': tripData,
                    'error': error.toString(),
                });
        }
    }

  void _showDialog(String title, String content) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
