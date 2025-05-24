import 'package:get/get.dart';
import '../models/article.dart';
import '../services/getarticle_api_service.dart';


class ArticleController extends GetxController {
  var isLoading = true.obs;
  var articles = <Article>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }


  void fetchArticles() async {
    try {
      isLoading(true);
      final fetchedArticles = await ArticleApiService.fetchArticles();
      articles.assignAll(fetchedArticles);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      articles.clear(); // Clear jika error
    } finally {
      isLoading(false);
    }
  }
}
