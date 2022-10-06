import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  // google map cntroller
  Completer<GoogleMapController> _controller = Completer();
  // current camera position
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14,
  );
  List<Marker> _marker = [];

  List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(24.8607, 67.0011),
        infoWindow: InfoWindow(title: "karachi")),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(25.3960, 68.3578),
        infoWindow: InfoWindow(title: "hyderabad")),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set.of(_marker),
            compassEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(25.3960, 68.3578), zoom: 14),
            ));
            setState(() {});
          },
          child: Icon(Icons.abc),
        ));
  }
}
