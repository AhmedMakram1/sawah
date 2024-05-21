import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
  final url = Uri.parse('http://192.168.1.9:5000/get_attractions');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the response body as JSON
      final List<dynamic> responseData = json.decode(response.body);

      // Convert the dynamic list to a list of maps with String keys
      final List<Map<String, dynamic>> attractionsData =
          List<Map<String, dynamic>>.from(responseData);

      return attractionsData;
    } else {
      // If the server response is not OK, throw an error
      throw Exception('Failed to load data from API');
    }
  } catch (error) {
    // Handle error
    print('Error: $error');
    throw error;
  }
}
