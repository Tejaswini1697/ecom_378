abstract class OrderEvent{}
class CreateOrderEvent extends OrderEvent{
  int productId;
  CreateOrderEvent({required this.productId});
}
class GetOrderEvent extends OrderEvent{}