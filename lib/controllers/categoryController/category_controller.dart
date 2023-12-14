import 'package:flowcash/common/ui.dart';
import 'package:flowcash/models/category.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../utils/loading_alert.dart';

part 'get_categories.dart';
part 'create_category.dart';
part 'update_category.dart';
part 'delete_category.dart';

class CategoryController extends GetxController {
  final categories = <Category>[].obs;

  @override
  void onInit() {
    refresh();
    super.onInit();
  }

  void refresh() {
    getCategories();
  }

  void getCategories() {
    categories.value = implementGetCategories();
  }

  void createCategory({
    required String categoryName,
  }) {
    return implementCreateCategory(
      categoryName: categoryName,
    );
  }

  void updateCategory({
    required String categoryName,
    required int categoryId,
  }) {
    return implementUpdateCategory(
      categoryName: categoryName,
      categoryId: categoryId,
    );
  }

  void deleteCategory({
    required int categoryId,
  }) {
    return implementDeleteCategory(
      categoryId: categoryId,
    );
  }

  String searchCategory(int id) {
    // ignore: invalid_use_of_protected_member
    for (var category in categories.value) {
      if (id == category.id) {
        return category.name!;
      }
    }
    return "Sem categoria";
  }
}
