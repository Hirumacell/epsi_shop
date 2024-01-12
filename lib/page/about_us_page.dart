import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AboutUs extends StatelessWidget {
  AboutUs({super.key});

  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton : FloatingActionButton(
        onPressed: () {
          mapController.move(LatLng(47.2061667,-1.5393851), 10);
        },
        child: const Icon(Icons.location_on),
      ),
      body: FlutterMap(
        options: const MapOptions(
            initialCenter: LatLng(47.2061667,-1.5393851),
            minZoom: 10,
            rotation: 0,
        ),
        mapController: mapController,
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          const MarkerLayer(
            markers: [
              Marker(
                child: Icon(Icons.school),
                point: LatLng(47.2061667,-1.5393851),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
