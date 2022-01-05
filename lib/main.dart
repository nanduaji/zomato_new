import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
void _openLocationSettings() async {
  final opened = await _geolocatorPlatform.openLocationSettings();
  // String displayValue;

  // if (opened) {
  //   displayValue = 'Opened Location Settings';
  // } else {
  //   displayValue = 'Error opening Location Settings';
  // }

  // _updatePositionList(
  //   _PositionItemType.log,
  //   displayValue,
  // );
}

class _MyAppState extends State<MyApp> {
  String location = '';
  // ignore: non_constant_identifier_names
  String Address = '';

  String Place = '';
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // return Future.error('Location services are disabled.');
      _openLocationSettings();
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    Address =
        '${place.street},${place.subLocality},${place.locality},${place.postalCode},${place.country},';
    Place = '${place.locality}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Zomato"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              onPressed: () async {
                Position position = await _determinePosition();
                location =
                    'Lat: ${position.latitude} , Long: ${position.longitude}';
                GetAddressFromLatLong(position);

                setState(() {});
              },
            )
          ],
        ),
        body: const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a search term',
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
