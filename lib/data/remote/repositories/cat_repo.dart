import '../../../domain/constants/app_urls.dart';
import '../helper/api_helper.dart';

class CatRepo {
  ApiHelper apiHelper;
  CatRepo({required this.apiHelper});

  Future<dynamic> fetchCategories() async {
    try {
      dynamic mData = await apiHelper.getApi(url: AppUrls.categoryUrl);
      return mData;

    } catch (e) {
      rethrow;
    }
  }

}