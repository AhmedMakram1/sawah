import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final List<Map<String, dynamic>> attractions;

  MapPage({Key? key, required this.attractions}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(29.033333, 29.933334);
  late Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _markers = {};

    for (var attraction in widget.attractions) {
      final marker = Marker(
        markerId: MarkerId(attraction['Attraction_Name']),
        position: LatLng(
          double.parse(attraction['Latitude'].toString()),
          double.parse(attraction['Longitude'].toString()),
        ),
        infoWindow: InfoWindow(
          title: attraction['Attraction_Name'],
        ),
        icon: BitmapDescriptor.defaultMarker, // Default marker for now
      );
      _markers.add(marker);
    }
    setState(() {}); // Update the state to reflect new markers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Attractions Map',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 6,
        ),
        markers: _markers,
      ),
    );
  }
}
