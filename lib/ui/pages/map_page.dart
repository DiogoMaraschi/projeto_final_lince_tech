import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  static const _position = LatLng(-23.5505, -46.6333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teste Mapa')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _position, zoom: 14),
        markers: {
          Marker(
            markerId: MarkerId('teste'),
            position: _position,
            infoWindow: InfoWindow(title: 'Local de teste'),
          ),
        },
      ),
    );
  }
}
