import 'package:flutter/material.dart';
import 'package:multi_store_app2/dashboard_components/mystore.dart';
import 'package:multi_store_app2/widgets/appbar_widgets.dart';

import '../dashboard_components/edit_buisiness.dart';
import '../dashboard_components/manage_products.dart';
import '../dashboard_components/supplier_balance.dart';
import '../dashboard_components/supplier_orders.dart';
import '../dashboard_components/supplier_statics.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statics',
];
List<IconData> icon = [
  Icons.store,
  Icons.shop_2_rounded,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

List<Widget> pages = const [
  MyStore(),
  SupplierOrders(),
  EditBusiness(),
  ManageProducts(),
  BalanceScreen(),
  Statics(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/Welcome_Screen');
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(
              6,
              (index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pages[index]),
                      );
                    },
                    child: Card(
                      shadowColor: Colors.purpleAccent,
                      elevation: 10,
                      color: Colors.blueGrey.withOpacity(0.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            icon[index],
                            size: 50,
                            color: Colors.yellow,
                          ),
                          Text(
                            label[index].toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Acme',
                              fontWeight: FontWeight.w600,
                              color: Colors.yellow,
                              letterSpacing: 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
