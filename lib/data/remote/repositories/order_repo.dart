import 'package:ecom_378/data/remote/helper/api_helper.dart';

import '../../../domain/constants/app_urls.dart';

class OrderRepository{
  ApiHelper apiHelper;
  OrderRepository({required this.apiHelper});
  Future<dynamic> createOrder({
    required int productId
    })async {
    try {
      return await apiHelper.postApi(
        url: AppUrls.createOrderUrl,
        bodyParams: {
          "product_id": productId
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getOrder() async {
    try {
      return await apiHelper.getApi(url: AppUrls.getOrderUrl);
    } catch (e) {
      rethrow;
    }
  }
}