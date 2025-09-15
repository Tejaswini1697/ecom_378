import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_widgets/navi_icon.dart';
import '../cart/cart_page.dart';
import 'bloc/product_bloc.dart';
import 'bloc/product_event.dart';
import 'home_screen.dart';

//import 'home_page(4).dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<DashboardPage> {
  int selectedPage = 2;

  List<Widget> mNavPages = [
    Scaffold(),
    HomePage(),
    HomePage(),
    CartPage(),
    HomePage(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetchEvent());
  }




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        shape: const CircleBorder(),
        onPressed: () {
          selectedPage = 2;
          setState(() {

          });
        },
        child: const Icon(Icons.home, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: SizedBox(
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  [
              NavIcon(icon: Icons.storefront_outlined, onTap: (){

              },),
              NavIcon(icon: Icons.favorite_border, onTap: (){

              }),
              SizedBox(width: 56), // space for FAB
              NavIcon(icon: Icons.shopping_cart_outlined, onTap: (){
                selectedPage = 3;
                setState(() {

                });
              }),
              NavIcon(icon: Icons.person_outline, onTap: (){

              }),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: mNavPages[selectedPage],
      ),
    );
  }



}
