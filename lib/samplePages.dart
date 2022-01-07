import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('AboutPage'),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('ServicesPage'),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List items;
  const CartPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("*********************$items");
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 50,
                color: Colors.red,
                child: Center(child: Text('${items[index]}')),
              ),
            ),
          );
        });
  }
}
