import '../../../domain/constants/app_urls.dart';
import '../helper/api_helper.dart';

class CartRepository {
  ApiHelper apiHelper;

  CartRepository({required this.apiHelper});

  Future<dynamic> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      return await apiHelper.postApi(
        url: AppUrls.addToCartUrl,
        bodyParams: {"product_id": productId, "quantity": quantity},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchCartItems() async {
    try {
      return await apiHelper.getApi(url: AppUrls.viewCartUrl);
    } catch (e) {
      rethrow;
    }
  }
}
