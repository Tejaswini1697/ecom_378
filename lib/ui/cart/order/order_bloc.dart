import 'package:ecom_378/data/remote/repositories/order_repo.dart';
import 'package:ecom_378/ui/cart/order/order_event.dart';
import 'package:ecom_378/ui/cart/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>
{
  OrderRepository orderRepository;
  OrderBloc({required this.orderRepository}) : super(OrderInitialState()){
    on<CreateOrderEvent>((event, emit) async{
      emit(OrderLoadingState());
      try {
        dynamic mData = await orderRepository.createOrder(
          productId: event.productId,
        );

        if(mData["status"]=="true"|| mData["status"]){
          emit(OrderSuccessState());

        } else{
          emit(OrderFailureState(errorMsg: mData["message"]));
        }

      } catch (e) {
        emit(OrderFailureState(errorMsg: e.toString()));
      }
    });
    on<GetOrderEvent>((event, emit) async{
      emit(OrderLoadingState());

      try{
        dynamic mData = await orderRepository.getOrder();
        if(mData["status"]){
          dynamic orders = mData["data"];
          //print("fetch from Cart: $cartItems");
          emit(OrderSuccessState(orders: orders));

        } else{
          emit(OrderFailureState(errorMsg: mData["message"]));
        }

      } catch (e){
        emit(OrderFailureState(errorMsg: e.toString()));
      }


    });

  }
}