import 'package:ecom_378/data/remote/repositories/cat_repo.dart';
import 'package:ecom_378/data/remote/repositories/order_repo.dart';
import 'package:ecom_378/ui/cart/cart_page.dart';
import 'package:ecom_378/ui/cart/order/order_bloc.dart';
import 'package:ecom_378/ui/dashboard/bloc/product_bloc.dart';
import 'package:ecom_378/ui/dashboard/cat_bloc/category_bloc.dart';
import 'package:ecom_378/ui/dashboard/home_screen.dart';
import 'package:ecom_378/ui/product_detail/bloc/cart_bloc.dart';
import 'package:ecom_378/ui/sign_up/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/remote/helper/api_helper.dart';
import 'data/remote/repositories/cart_repo.dart';
import 'data/remote/repositories/product_repo.dart';
import 'data/remote/repositories/user_repo.dart';
import 'domain/constants/app_routes.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserBloc(userRepo: UserRepo(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            productRepository: ProductRepository(apiHelper: ApiHelper()),
          ),
        ),
        BlocProvider(
          create: (context) =>
              CartBloc(cartRepository: CartRepository(apiHelper: ApiHelper())),
        ),
        BlocProvider(create: (context) => CategoryBloc(catRepo: CatRepo(apiHelper: ApiHelper()))),
        BlocProvider(create: (context) => OrderBloc(orderRepository: OrderRepository(apiHelper: ApiHelper()))),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
     //home: CartPage(),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
