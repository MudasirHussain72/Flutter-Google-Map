import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatlangToAddress extends StatefulWidget {
  const ConvertLatlangToAddress({super.key});

  @override
  State<ConvertLatlangToAddress> createState() =>
      _ConvertLatlangToAddressState();
}

class _ConvertLatlangToAddressState extends State<ConvertLatlangToAddress> {
  var stAddress = "", stAdd = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("google map"),
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              stAddress,
              style: TextStyle(color: Colors.green),
            ),
            Text(
              stAdd,
              style: TextStyle(color: Colors.green),
            ),
            GestureDetector(
              onTap: () async {
                // From a query
                List<Location> locations =
                    await locationFromAddress("Gronausestraat 710, Enschede");

                List<Placemark> placemarks =
                    await placemarkFromCoordinates(24.771042, 67.056997);
                // final coordinates = Coordinates(24.771042, 67.056997);
                setState(() {
                  stAddress = locations.last.latitude.toString() +
                      " " +
                      locations.last.longitude.toString();
                  stAdd = placemarks.reversed.last.subLocality.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Center(child: Text("convert")),
                ),
              ),
            )
          ]),
    );
  }
}
