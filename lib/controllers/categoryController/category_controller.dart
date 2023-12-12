import 'package:flowcash/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../data/categories.dart';
import '../../utils/alert/alert_dialog.dart';
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
  }) {
    return implementUpdateCategory(
      context: context,
      categoryName: categoryName,
      categoryId: categoryId,
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
