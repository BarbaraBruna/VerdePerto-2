import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatefulWidget {
  const SimpleMap({Key? key}) : super(key: key);

  @override
  State<SimpleMap> createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  final Completer<GoogleMapController> _controller =
      Completer(); //criei um controller para o maps

  static const CameraPosition
      initialPosition = //posição inicial do mapa //trocar para posição local do usuario
      CameraPosition(target: LatLng(-19.8157, -43.9542), zoom: 14.0);

  static const CameraPosition targetPosition =
      CameraPosition(target: LatLng(-19.7057, -43.9542), zoom: 14.0); //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Google Maps"),
        centerTitle: true,
      ),
      body: Container(
        width: 400,
        height: 400,
        child: GoogleMap(
          initialCameraPosition: initialPosition,
          mapType: MapType.satellite,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          goToCurrentLocation();
        },
        label: Text("Vá para a sua localização!!"),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  }
}
