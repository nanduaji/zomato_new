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
                },
              ),
              bottomNavigationBar: _buildTotalContainer(),
      ),
    );
  }

  Widget _buildTotalContainer(){
    return Container(
      height: 220.0,
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                "Subtotal",
                style: TextStyle(
                    color: Color(0xFF9BA7C6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "23.0",
                style: TextStyle(
                    color: Color(0xFF6C6D6D),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                "Discount",
                style: TextStyle(
                    color: Color(0xFF9BA7C6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "10.0",
                style: TextStyle(
                    color: Color(0xFF6C6D6D),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                "Tax",
                style: TextStyle(
                    color: Color(0xFF9BA7C6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "0.5",
                style: TextStyle(
                    color: Color(0xFF6C6D6D),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 2.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                "Cart Total",
                style: TextStyle(
                    color: Color(0xFF9BA7C6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "26.5",
                style: TextStyle(
                    color: Color(0xFF6C6D6D),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            // onTap: () {
            //   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignInPage()));
            // },
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                // color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: const Center(
                child: Text(
                  "Proceed To Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

// class CartPage extends StatefulWidget {
//   @override
//   _OrderPageState createState() => _OrderPageState();
// }

// class _OrderPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 10.0),
//         scrollDirection: Axis.vertical,
//         children: <Widget>[
//           // OrderCard(),
//           // OrderCard(),
//         ],
//       ),
//       bottomNavigationBar: _buildTotalContainer(),
//     );
//   }

//   Widget _buildTotalContainer() {
//     return Container(
//       height: 220.0,
//       padding: EdgeInsets.only(
//         left: 10.0,
//         right: 10.0,
//       ),
//       child: Column(
//         children: <Widget>[
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 "Subtotal",
//                 style: TextStyle(
//                     color: Color(0xFF9BA7C6),
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "23.0",
//                 style: TextStyle(
//                     color: Color(0xFF6C6D6D),
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 "Discount",
//                 style: TextStyle(
//                     color: Color(0xFF9BA7C6),
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "10.0",
//                 style: TextStyle(
//                     color: Color(0xFF6C6D6D),
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 "Tax",
//                 style: TextStyle(
//                     color: Color(0xFF9BA7C6),
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "0.5",
//                 style: TextStyle(
//                     color: Color(0xFF6C6D6D),
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Divider(
//             height: 2.0,
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 "Cart Total",
//                 style: TextStyle(
//                     color: Color(0xFF9BA7C6),
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "26.5",
//                 style: TextStyle(
//                     color: Color(0xFF6C6D6D),
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           GestureDetector(
//             // onTap: () {
//             //   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignInPage()));
//             // },
//             child: Container(
//               height: 50.0,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius: BorderRadius.circular(35.0),
//               ),
//               child: Center(
//                 child: Text(
//                   "Proceed To Checkout",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
