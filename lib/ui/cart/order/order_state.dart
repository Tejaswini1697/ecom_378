abstract class OrderState {}
class OrderInitialState extends OrderState{}
class OrderLoadingState extends OrderState{}
class OrderSuccessState extends OrderState{
 dynamic? orders;
  OrderSuccessState({this.orders});

}
class OrderFailureState extends OrderState{
  String errorMsg;
  OrderFailureState({required this.errorMsg});
}