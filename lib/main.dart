import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zomato_new/samplePages.dart';

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
}

class _MyAppState extends State<MyApp> {
  final myController = TextEditingController();
  String location = '';
  // ignore: non_constant_identifier_names
  String Address = '';

  String Place = '';

  int _selectedItems = 0;

  int currentCount = 0;

  bool Value = false;

  static List<dynamic> selectedItems = [];

  static List<String> mainDataList = [
    "Apple",
    "Apricot",
    "Banana",
    "Blackberry",
    "Coconut",
    "Date",
    "Fig",
    "Gooseberry",
    "Grapes",
    "Lemon",
    "Litchi",
    "Mango",
    "Orange",
    "Papaya",
    "Peach",
    "Pomegranate",
    "Starfruit"
  ];

  final _pagesContent = [
    const AboutPage(),
    const ServicesPage(),
    CartPage(
      items: selectedItems,
    )
  ];
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
    Place = '${place.subLocality}';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    newDataList = [];
  }

  getLocation() async {
    Position position = await _determinePosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);

    setState(() {});
  }

  addCounter() {
    currentCount = currentCount + 1;

    currentCount >= 10 ? currentCount = 10 : currentCount;
    setState(() {
      currentCount;
    });
    // selectedItems.add(text);
  }

  subCounter() {
    currentCount = currentCount - 1;
    currentCount < 0 ? currentCount = 0 : currentCount;
    setState(() {
      currentCount;
    });
  }

  addTocart(text) {
    selectedItems.add(text);
  }

  List<String> newDataList = List.from(mainDataList);
  onItemChanged(String value) {
    if (value != '') {
      setState(() {
        newDataList = mainDataList
            .where(
              (string) => string.toLowerCase().contains(
                    value.toLowerCase(),
                  ),
            )
            .toList();
        Value = true;
      });
    } else {
      setState(
        () {
          newDataList = [];
          Value = false;
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _selectedItems == 0
            ? AppBar(
                title: Text("Zomato"),
                backgroundColor: Colors.red,
                actions: <Widget>[
                  Row(
                    children: [
                      Text(Place),
                      IconButton(
                        icon: Icon(
                          Place == '' ? Icons.location_off : Icons.location_on,
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
                ],
              )
            : null,
        body: Place != ''
            ? _selectedItems == 0
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: myController,
                                decoration: const InputDecoration(
                                  hintText: 'Search Dishes',
                                  icon: Icon(Icons.search),
                                ),
                                onChanged: onItemChanged,
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Wrap(
                                      children: [
                                        InkWell(
                                          child: Text(
                                            newDataList.join(","),
                                          ),
                                          onTap: () {
                                            addTocart(newDataList.join(","),);
                                          },
                                        ),
                                        Value == true
                                            ? Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      subCounter();
                                                    },
                                                    child: Icon(Icons.remove),
                                                  ),
                                                  Text("$currentCount"),
                                                  TextButton(
                                                    onPressed: () {
                                                      addCounter();
                                                    },
                                                    child: Icon(Icons.add),
                                                  ),
                                                ],
                                              )
                                            : Row(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: InkWell(
                                child: Container(
                                  child: Image.asset("assets/Food1.jpg",
                                      width: 380, height: 380),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: InkWell(
                                child: Container(
                                  child: Image.asset(
                                    "assets/Food2.jpg",
                                    width: 380,
                                    height: 380,
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: InkWell(
                                child: Container(
                                  child: Image.asset("assets/Food3.jpg",
                                      width: 380, height: 380),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : _selectedItems == 1
                    ? _pagesContent[0]
                    : _selectedItems == 2
                        ? _pagesContent[1]
                        : _selectedItems == 3
                            ? _pagesContent[2]
                            : null
            : null,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_rounded),
                label: "About",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Services",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: "Cart",
              ),
            ],
            onTap: (value) {
              setState(() {
                _selectedItems = value;
              });
            },
            currentIndex: _selectedItems),
      ),
    );
  }
}
