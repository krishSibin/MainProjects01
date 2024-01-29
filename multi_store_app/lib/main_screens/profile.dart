import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app2/customer_screens/customer_orders.dart';
import 'package:multi_store_app2/customer_screens/wishlist.dart';
import 'package:multi_store_app2/main_screens/cart.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';

import '../widgets/alert_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow, Colors.brown],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,
                centerTitle: true,
                pinned: true,
                backgroundColor: Colors.white,
                expandedHeight: MediaQuery.of(context).size.width * 0.6,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        opacity: constraints.biggest.height <= 120 ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.2,
                            top: 40,
                          ),
                          child: const Center(
                            child: Text(
                              'Account',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.brown],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 25,
                            left: 30,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('images/inapp/guest.jpg'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(
                                  'guest'.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                              ),
                            ),
                            child: TextButton(
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: FittedBox(
                                    child: Text(
                                      'Cart',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.yellow),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(
                                      back: AppBarBackButton(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.lime,
                            ),
                            child: TextButton(
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: FittedBox(
                                    child: Text(
                                      'Orders',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomerOrders(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            child: TextButton(
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: FittedBox(
                                    child: Text(
                                      'WishList',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WishlistScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            child: Image.asset('images/inapp/logo.jpg'),
                          ),
                          const ProfileHeaderLabel(headerLabel: 'Account Info'),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 260,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const RepeatedListFile(
                                    title: 'Email Address',
                                    subtitle: 'example@gmail.com',
                                    icon: Icons.email_outlined,
                                  ),
                                  const YellowDivider(),
                                  RepeatedListFile(
                                      title: 'Phone Number',
                                      subtitle: '+12345',
                                      icon: Icons.phone,
                                      onpressed: () {}),
                                  const YellowDivider(),
                                  RepeatedListFile(
                                    title: 'Address',
                                    subtitle: 'example: 140 st - New Gersy',
                                    icon: Icons.location_on_outlined,
                                    onpressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const ProfileHeaderLabel(
                              headerLabel: 'Account Settings'),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 260,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  RepeatedListFile(
                                    title: 'Edit Profile',
                                    icon: Icons.edit,
                                    onpressed: () {},
                                  ),
                                  const YellowDivider(),
                                  RepeatedListFile(
                                    title: 'Change Password',
                                    icon: Icons.lock,
                                    onpressed: () {},
                                  ),
                                  const YellowDivider(),
                                  RepeatedListFile(
                                    title: 'Log Out',
                                    icon: Icons.logout,
                                    onpressed: () async {
                                      MyAlertDialog.showMyDialog(
                                        context: context,
                                        title: "Warning",
                                        content: "You are about log out",
                                        tapNo: () {
                                          Navigator.pop(context);
                                        },
                                        tapYes: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Navigator.pop(context);
                                          Navigator.pushReplacementNamed(
                                              context, '/Welcome_Screen');
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListFile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function()? onpressed;

  const RepeatedListFile({
    super.key,
    required this.title,
    this.subtitle = '',
    required this.icon,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const ProfileHeaderLabel({
    super.key,
    required this.headerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
                color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
