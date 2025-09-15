import 'package:ecom_378/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/remote/models/product_model.dart';
import 'bloc/cart_bloc.dart';
import 'bloc/cart_event.dart';
import 'bloc/cart_state.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductModel? selectedProduct;

  int qty = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    selectedProduct =
        ModalRoute.of(context)?.settings.arguments as ProductModel;

    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        selectedProduct != null ? selectedProduct!.image! : "",
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  selectedProduct!.name!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '\$${selectedProduct!.price}',
                  style: TextStyle(fontSize: 20, color: Colors.orange),
                ),
                SizedBox(height: 8),
                Text(
                  'Seller: Tariqul Islam',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 20),
                    SizedBox(width: 4),
                    Text('4.8', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 4),
                    Text(
                      '(320 Review)',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    ColorDot(color: Colors.red),
                    ColorDot(color: Colors.black),
                    ColorDot(color: Colors.blue),
                    ColorDot(color: Colors.grey),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.deepOrange
                      ),
                      child: Text("Description", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    Spacer(),
                    Text("Specification"),
                    Spacer(),
                    Text("Reviews")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Text("Eccnfamdho noxcdweo afjdofjei odmnasi"
                      " Edfdfjnbdh jdjfoekre fdjkfosfjd fjkodfod jieu9hhdsdup"
                      "Eccnfamdho noxcdweo afjdofjei odmnasi"
                      " Edfdfjnbdh jdjfoekre fdjkfosfjd fjkodfod jieu9hhdsdup"
                      " Eccnfamdho noxcdweo afjdofjei odmnasi"
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 31),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white),
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
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          Text(
                            "$qty",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              qty++;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocConsumer<CartBloc, CartState>(
                      listener: (_, state){

                        if(state is CartLoadingState){
                          isLoading = true;
                        }

                        if(state is CartFailureState){
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMsg), backgroundColor: Colors.red,),
                          );
                        }

                        if(state is CartSuccessState){
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Product added to cart"), backgroundColor: Colors.green,),
                          );
                          Navigator.pop(context);

                        }

                      },
                      builder: (context, state) {
                        return Container(
                          height: 38,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF6A00),
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                AddToCartEvent(
                                  productId: int.parse(selectedProduct!.id!),
                                  quantity: qty,
                                ),
                              );

                            },
                            child: isLoading ? Center(child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )) : Text(
                              "Add to Cart",
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;

  const ColorDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      height: 30,
      width: 30,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
