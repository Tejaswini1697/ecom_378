
import '../../../data/remote/models/product_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}
class ProductLoadingState extends ProductState {}
class ProductLoadedState extends ProductState {
  List<ProductModel> allProducts;
  ProductLoadedState({required this.allProducts});
}
class ProductErrorState extends ProductState {
  String errorMsg;
  ProductErrorState({required this.errorMsg});
}