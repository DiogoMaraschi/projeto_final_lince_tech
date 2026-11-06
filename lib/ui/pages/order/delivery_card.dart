import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({
    super.key,
    required this.setController,
    required this.storeLocation,
    required this.customerLocation,
  });

  final ValueChanged<GoogleMapController> setController;
  final LatLng storeLocation;
  final LatLng customerLocation;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined, color: colors.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rua XV de Novembro, 1450'),
                      Text('Blumenau/SC · CEP 89010-100'),
                      const SizedBox(height: 12),
                      Text('Distância da entrega: 6 km'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 220,
            child: GoogleMap(
              onMapCreated: setController,
              initialCameraPosition: CameraPosition(
                target: LatLng(-26.9194, -49.0661),
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('store_marker'),
                  position: storeLocation,
                  infoWindow: InfoWindow(title: 'Local da Loja'),
                ),
                Marker(
                  markerId: MarkerId('customer_marker'),
                  position: customerLocation,
                  infoWindow: InfoWindow(title: 'Local da Cliente'),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
