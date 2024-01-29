import 'package:flutter/material.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';

import '../widgets/yellow_button.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;

  const CartScreen({super.key, this.back});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Cart',
        ),
        centerTitle: true,
        leading: widget.back,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Your Cart is Empty',
              style: TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Material(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(25),
            child: MaterialButton(
              onPressed: () {
                Navigator.canPop(context)
                    ? Navigator.pop(context)
                    : Navigator.pushReplacementNamed(context, '/Customer_home');
              },
              minWidth: MediaQuery.of(context).size.width * 0.5,
              height: 40,
              child: const Text(
                'Continue Shopping',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Row(
              children: [
                Text(
                  'Total \$ ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "00.00",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            YellowButton(label: 'Check Out', width: 0.35, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
