
import '../../../domain/constants/app_urls.dart';
import '../helper/api_helper.dart';

class ProductRepository {
  ApiHelper apiHelper;

  ProductRepository({required this.apiHelper});

  Future<dynamic> fetchProducts() async {
    try {
      dynamic mData = await apiHelper.postApi(url: AppUrls.productUrl);
      return mData;
    } catch (e) {
      rethrow;
    }
  }
}
