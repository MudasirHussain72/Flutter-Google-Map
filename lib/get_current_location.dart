import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({super.key});

  @override
  State<GetCurrentLocation> createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  // google map cntroller
  Completer<GoogleMapController> _controller = Completer();
  // current camera position
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14,
  );

  List<Marker> _markers = [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(24.8607, 67.0011),
        infoWindow: InfoWindow(title: "karachi")),
  ];
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error:" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set<Marker>.of(_markers),
            compassEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            getUserCurrentLocation().then((value) async {
              print(
                  value.latitude.toString() + " " + value.longitude.toString());
              _markers.add(Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(title: "my loca")));
              CameraPosition cameraPosition = CameraPosition(
                  zoom: 14, target: LatLng(value.latitude, value.longitude));
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {});
            });
          },
          child: Icon(Icons.abc),
        ));
  }
}
