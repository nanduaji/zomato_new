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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
          backgroundColor: Colors.red,
        ),
        // ignore: unrelated_type_equality_checks
        body: items.length == 0
            ? const Center(
                child: Text("Add Something To The Cart"),
              )
            : ListView.builder(
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
                }),
      ),
    );
  }
}
