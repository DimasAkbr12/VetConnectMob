import 'package:get/get.dart';
import '../models/article.dart';
import '../services/article_api_service.dart';

class ArticleController extends GetxController {
  final articles = <Article>[].obs;
  final isLoading = false.obs;
  final service = ArticleService();

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      articles.value = await service.fetchAllArticles();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
