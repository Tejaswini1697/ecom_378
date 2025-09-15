
import 'package:ecom_378/data/remote/models/product_model.dart';

abstract class CartState{}

class CartInitialState extends CartState{}
class CartLoadingState extends CartState{}
class CartSuccessState extends CartState{
  dynamic? cartItems;
  CartSuccessState({this.cartItems});
}
class CartFailureState extends CartState{
  String errorMsg;
  CartFailureState({required this.errorMsg});
}