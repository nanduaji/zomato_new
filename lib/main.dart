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

  int _selectedItems = 0;

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
    "Pineapple",
    "Pomegranate",
    "Starfruit"
  ];

  final _pagesContent = [const AboutPage(), const ServicesPage()];
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
  }

  getLocation() async {
    Position position = await _determinePosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);

    setState(() {});
  }

  List<String> newDataList = List.from(mainDataList);
  onItemChanged(String value) {
    if (value != '') {
      setState(() {
        newDataList = mainDataList
            .where(
                (string) => string.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
      print("***************$newDataList");
    } else {
      setState(
        () {
          newDataList = [];
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
        ),
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
                                decoration: const InputDecoration(
                                  hintText: 'Enter a search term',
                                  icon: Icon(Icons.search),
                                ),
                                onChanged: onItemChanged,
                              ),
                              trailing: Text('$newDataList'),
                            ),
                          ),
                          // Expanded(
                          //   child: ListView(
                          //       padding: EdgeInsets.all(12.0),
                          //       children: newDataList.map(
                          //         (data) {
                          //           return ListTile(
                          //             title: Text(data),
                          //             onTap: () => print(data),
                          //           );
                          //         },
                          //       ).toList()),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                child: Image.asset("assets/Food1.jpg",
                                    width: 380, height: 380),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                child: Image.asset("assets/Food2.jpg",
                                    width: 380, height: 380),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                child: Image.asset("assets/Food3.jpg",
                                    width: 380, height: 380),
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
                        : null
            : null,
        bottomNavigationBar: BottomNavigationBar(
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
