import 'package:flutter/material.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Wishlist Screen',
        ),
        leading: const AppBarBackButton(),
        centerTitle: true,
      ),
    );
  }
}
