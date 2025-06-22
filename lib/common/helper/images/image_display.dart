import 'package:ecommerce/core/constants/app_urls.dart';

class ImageDisplayHelper {
  static String generateCategoryImageUrl(String title) {
    // return AppUrl.categoryImage + title + AppUrl.alt;
    return AppUrl.storageBase + title;
  }

  static String generateProductImageURL(String title) {
    return AppUrl.storageBase + title;
  }
}
