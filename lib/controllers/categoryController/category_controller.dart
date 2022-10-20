import 'package:cas/data/categories.dart';
import 'package:cas/utils/alert_dialog.dart';
import 'package:cas/utils/loading_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'get_categories.dart';
part 'delete_categories.dart';

class CategoryController {
  static void getCategories() {
    return implementGetCategories();
  }

  static void deleteCategory({
    required BuildContext context,
    required int categoryId,
    required Function() onRefresh,
  }) {
    return implementDeleteCategory(
      context: context,
      categoryId: categoryId,
      onRefresh: onRefresh,
    );
  }
}
