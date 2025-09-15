import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/remote/repositories/cart_repo.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitialState()) {
    on<AddToCartEvent>((event, emit) async{
      emit(CartLoadingState());
      try {
        dynamic mData = await cartRepository.addToCart(
          productId: event.productId,
          quantity: event.quantity,
        );

        if(mData["status"]=="true"|| mData["status"]){
          emit(CartSuccessState());

        } else{
          emit(CartFailureState(errorMsg: mData["message"]));
        }

      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });

    on<FetchCartItemsEvent>((event, emit) async{
      emit(CartLoadingState());

      try{
        dynamic mData = await cartRepository.fetchCartItems();
        if(mData["status"]){
          dynamic cartItems = mData["data"];
          //print("fetch from Cart: $cartItems");
          emit(CartSuccessState(cartItems: cartItems));

        } else{
          emit(CartFailureState(errorMsg: mData["message"]));
        }

      } catch (e){
        emit(CartFailureState(errorMsg: e.toString()));
      }


    });
  }
}
