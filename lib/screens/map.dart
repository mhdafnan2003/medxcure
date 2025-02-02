import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  // Sample data for places to mark on the map
  final List<Map<String, dynamic>> places = [
    {
      'name': 'Rajagiri Hospital',
      'location': LatLng(10.0876, 76.3882), // Rajagiri Hospital coordinates
    },
    {
      'name': 'Lissie Hospital',
      'location': LatLng(9.9887, 76.2880), // Lissie Hospital coordinates
    },
    {
      'name': 'Amrita Hospital',
      'location': LatLng(10.0328, 76.2930), // Amrita Hospital coordinates
    },
    {
      'name': 'Apollo Hospital',
      'location': LatLng(10.2395, 76.3727), // Apollo Hospital coordinates
    },
    {
      'name': 'Little Flower Hospital',
      'location': LatLng(10.1911, 76.3896), // Little Flower Hospital coordinates
    },
    {
      'name': 'Sree Gokulam Medical College',
      'location': LatLng(8.6918, 76.9140), // Sree Gokulam Medical College coordinates
    },
    {
      'name': 'Amala Hospital',
      'location': LatLng(10.5615, 76.1680), // Amala Hospital coordinates
    },
    {
      'name': 'Bharath Hospital',
      'location': LatLng(9.5895, 76.5195), // Amala Hospital coordinates
    },
    {
      'name': 'KIMS Hospital',
      'location': LatLng(8.8647, 76.6814), // Amala Hospital coordinates
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Near by Hospitals")),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(10.0876, 76.3882), // Center the map on Rajagiri Hospital
          zoom: 10.0,  // Default zoom level
          minZoom: 3.0, // Minimum zoom
          maxZoom: 18.0, // Maximum zoom
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer( // Add MarkerLayer to display markers
            markers: places.map((place) {
              return Marker(
                point: place['location'],
                width: 80.0, // Width of the marker
                height: 120.0, // Height of the marker
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Use min size to avoid overflow
                  children: [
                    Icon(
                      Icons.local_hospital,
                      color: Colors.red,
                      size: 30,
                    ),
                    Text(
                      place['name'],
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}