import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderController extends GetxController {
  final box = GetStorage();
  final OrderService _orderService = OrderService();

  var order = Rxn<OrderModel>();
  var isLoading = false.obs;

  Future<void> fetchOrder(int orderId) async {
    try {
      isLoading.value = true;
      String token = box.read('token') ?? '';
      order.value = await _orderService.getOrderById(orderId, token);
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
