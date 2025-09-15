import 'package:ecom_378/ui/app_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../product_detail/bloc/cart_bloc.dart';
import '../product_detail/bloc/cart_event.dart';
import '../product_detail/bloc/cart_state.dart';
import 'order/order_bloc.dart';
import 'order/order_event.dart';
import 'order/order_state.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
   bool isLoading = false;
   int qty = 1;

   @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    int qty = 1;
    List<Map<String, dynamic>> cartItems = [
      {
        "name": 'Woman Sweater',
        "category": 'Woman Fashion',
        "price": 70.00,
        "quantity": 1,
        "imageUrl": 'assets/images/ecom_splash.jpg',
      },
      {
        "name": 'Smart Watch',
        "category": 'Electronics',
        "price": 55.00,
        "quantity": 1,
        "imageUrl": 'assets/images/ecom_splash.jpg',
      },
      {
        "name": 'Wireless Headphone',
        "category": 'Electronics',
        "price": 55.00,
        "quantity": 1,
        "imageUrl": 'assets/images/ecom_splash.jpg',
      },

    ];
    return Scaffold(
      appBar: AppBar(title: Text("My Cart")),
      body:SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CartBloc, CartState>
              (
                builder: (context, state) {
              if(state is CartLoadingState)
              {
                return Center(child: CircularProgressIndicator(),);
              }
              if(state is CartFailureState)
              {
                return Center(child: Text(state.errorMsg));
              }
              if(state is CartSuccessState)
              {
                print("cartpage data: ${state.cartItems}");
                Text("Text");
        
                state.cartItems.isNotEmpty ?
        
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = state.cartItems[index];
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset(item['imageUrl'], width: 80, height: 80),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(item['category'], style: TextStyle(color: Colors.grey[600])),
                                        Text('\$${item['price'].toStringAsFixed(2)}'),
                                      ],
                                    ),
                                  ),
        
                                  Column(
                                    children: [
                                      IconButton(onPressed: (){
                                        state.cartItems.remove(item);
                                      },
                                        icon: Icon(Icons.delete, color: Colors.deepOrange, size: 20,),),
        
                                      SizedBox(height: 20,),
                                      Container(
                                        height: 30,
                                        width: 80,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: Colors.grey.shade300),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (qty > 1) {
                                                  qty--;
                                                  setState(() {});
                                                }
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 16,
                                              ),
                                            ),
                                            Text(
                                              "$qty",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                qty++;
                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.add,
                                                size: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Subtotal'),
                                                  Text('\$${state.cartItems.fold(0.0, (sum, item) => sum + (int.parse(item['price']) * item['quantity'])).toStringAsFixed(2)}'),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                                                  Text('\$${state.cartItems.fold(0.0, (sum, item) => sum + (int.parse(item['price']) * item['quantity'])).toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                                                ],
                                              ),
                                              SizedBox(height: 16),
                                              BlocConsumer<OrderBloc, OrderState>(
                                    listener:(_, state){
                                      if(state is OrderLoadingState)
                                      {
                                        isLoading = true;
                                      }
                                      if(state is OrderSuccessState)
                                      {
                                        isLoading = false;
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Order created successfully"), backgroundColor: Colors.green,));
                                      }
                                      if(state is OrderFailureState)
                                      {
                                        isLoading = false;
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(state.errorMsg), backgroundColor: Colors.red,));
                                      }
                                    },
                                    builder: (context, state){
                                      return  PrimaryButton(
                                          label:isLoading? "Please wait...":"Order",
                                          onPressed: (){
                                            context.read<OrderBloc>().add(CreateOrderEvent(
                                                productId: item["id"],
                                                ));
                                          });
                                    })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                )
                    : Center(
                  child: Text("No cart items yet"),
                );
        
              }
              return Container();
        
            }),

          ],
        ),
      ),


    );
  }
}
/*import 'package:ecom_378/ui/app_widgets/primary_button.dart';
import 'package:ecom_378/ui/cart/order/order_bloc.dart';
import 'package:ecom_378/ui/cart/order/order_event.dart';
import 'package:ecom_378/ui/cart/order/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;
  int qty = 1;
  List<Map<String, dynamic>> cartItems = [
    {
      "id":1,
      "name": 'Woman Sweater',
      "category": 'Woman Fashion',
      "price": 70.00,
      "quantity": 1,
      "imageUrl": 'assets/images/ecom_splash.jpg',
    },
    {
      "id":2,
      "name": 'Smart Watch',
      "category": 'Electronics',
      "price": 55.00,
      "quantity": 1,
      "imageUrl": 'assets/images/ecom_splash.jpg',
    },
    {
      "id":3,
      "name": 'Wireless Headphone',
      "category": 'Electronics',
      "price": 55.00,
      "quantity": 1,
      "imageUrl": 'assets/images/ecom_splash.jpg',
    },

  ];

  double get totalAmount {
    return cartItems.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(item['imageUrl'], width: 80, height: 80),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(item['category'], style: TextStyle(color: Colors.grey[600])),
                              Text('\$${item['price'].toStringAsFixed(2)}'),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            IconButton(onPressed: (){
                             cartItems.remove(item);
                            },
                              icon: Icon(Icons.delete, color: Colors.deepOrange, size: 20,),),

                            SizedBox(height: 20,),
                            Container(
                              height: 30,
                              width: 80,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (qty > 1) {
                                        qty--;
                                        setState(() {});
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    "$qty",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      qty++;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Subtotal'),
                                    Text('\$${totalAmount.toStringAsFixed(2)}'),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('\$${totalAmount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(height: 16),
                                BlocConsumer<OrderBloc, OrderState>(
                                    listener:(_, state){
                                      if(state is OrderLoadingState)
                                      {
                                        isLoading = true;
                                      }
                                      if(state is OrderSuccessState)
                                      {
                                        isLoading = false;
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Order created successfully"), backgroundColor: Colors.green,));
                                      }
                                      if(state is OrderFailureState)
                                      {
                                        isLoading = false;
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(state.errorMsg), backgroundColor: Colors.red,));
                                      }
                                    },
                                    builder: (context, state){
                                      return  PrimaryButton(
                                          label:isLoading? "Please wait...":"Order",
                                          onPressed: (){
                                            context.read<OrderBloc>().add(CreateOrderEvent(
                                                productId: item["id"],
                                                ));
                                          });
                                    })


                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}*/
