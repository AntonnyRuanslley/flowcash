import 'package:cas/data/categories.dart';
import 'package:cas/utils/alert/alert_dialog.dart';
import 'package:cas/utils/alert/alert_snack_bar.dart';
import 'package:cas/utils/alert/alert_snack_bar_II.dart';
import 'package:cas/utils/loading_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'get_categories.dart';
part 'create_category.dart';
part 'update_category.dart';
part 'delete_category.dart';

class CategoryController {
  static void getCategories() {
    return implementGetCategories();
  }

  static void createCategory({
    required BuildContext context,
    required String categoryName,
  }) {
    return implementCreateCategory(
      context: context,
      categoryName: categoryName,
    );
  }

  static updateCategory({
    required BuildContext context,
    required String categoryName,
    required int categoryId,
    required Function() onRefresh,
  }) {
    return implementUpdateCategory(
      context: context,
      categoryName: categoryName,
      categoryId: categoryId,
      onRefresh: onRefresh,
    );
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
