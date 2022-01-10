import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zomato_new/samplePages.dart';
import 'package:http/http.dart' as http;

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

class Data {
  final String name;
  final int price;
  Data({
    required this.name,
    required this.price,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      price: json['price'],
    );
  }
}

class _MyAppState extends State<MyApp> {
  final myController = TextEditingController();
  String location = '';
  // ignore: non_constant_identifier_names
  String Address = '';

  String Place = '';

  int _selectedItems = 0;

  static int currentCount = 0;

  bool Value = false;

  static List<dynamic> selectedItems = [];

  int Price = 0;

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

  static List<int> priceOfVariables = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

  final _pagesContent = [
    const AboutPage(),
    const ServicesPage(),
    CartPage(
      items: selectedItems,
      // count: currentCount,
      // location: Place,
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

  // List<String> newDataList1 = List.from(mainDataList);
  Iterable newData = mainDataList.map((data) => data);
  @override
  void initState() {
    super.initState();
    getLocation();
    // futureData = getData();
    newDataList = [];
  }

  getLocation() async {
    Position position = await _determinePosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);

    setState(() {});
  }

  Future<Data> getData() async {
    final http.Response response = await http.get(
      Uri.parse("https://run.mocky.io/v3/c8c033fa-b0d5-4d2e-8988-fef388d39a3f"),
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );
    if (response.statusCode == 200) {
      print("*********************${Data.fromJson(jsonDecode(response.body))}");
      return Data.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load data');
    }
  }

  addCounter() {
    currentCount = currentCount + 1;

    currentCount >= 10 ? currentCount = 10 : currentCount;
    setState(() {
      currentCount;
    });
    getData();
  }

  subCounter() {
    currentCount = currentCount - 1;
    currentCount < 0 ? currentCount = 0 : currentCount;
    setState(() {
      currentCount;
    });
  }

  addTocart(text) {
    currentCount > 0 ? selectedItems.add(text) : null;
  }

  removeFromCart(text) {
    selectedItems.remove(text);
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
          currentCount = 0;
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
                                        ),
                                        Value == true
                                            ? Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      subCounter();
                                                      removeFromCart(
                                                        newDataList.join(","),
                                                      );
                                                    },
                                                    child: Icon(Icons.remove),
                                                  ),
                                                  Text("$currentCount"),
                                                  TextButton(
                                                    onPressed: () {
                                                      addCounter();
                                                      addTocart(
                                                        newDataList.join(","),
                                                      );
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
                                  child: Image.asset(
                                    "assets/Food4.jpg",
                                    // width: 380, height: 380
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
                                  child: Image.asset(
                                    "assets/Food1.jpg",
                                    // width: 180,
                                    // height: 180,
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Card(
                                child: InkWell(
                                  child: Container(
                                    child: Image.asset(
                                      "assets/Food3.jpg",
                                      width: 380,
                                      height: 380,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
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
