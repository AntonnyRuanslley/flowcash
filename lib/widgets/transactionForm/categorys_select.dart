// ignore_for_file: invalid_use_of_protected_member

import 'package:flowcash/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_theme.dart';
import '../../models/category.dart';
import '../../controllers/categoryController/category_controller.dart';

class CategorysSelect extends StatefulWidget {
  final Function(int) onSubmit;
  final int? categoryId;

  const CategorysSelect({
    Key? key,
    required this.onSubmit,
    this.categoryId,
  }) : super(key: key);

  @override
  State<CategorysSelect> createState() => _CategorysSelectState();
}

class _CategorysSelectState extends State<CategorysSelect> {
  int? category;

  @override
  void initState() {
    super.initState();
    if (widget.categoryId != null) {
      final Category categorySelected = Get.find<CategoryController>()
          .categories
          .value
          .firstWhere((category) => category.id == widget.categoryId);
      category = categorySelected.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);
    final categories = Get.find<CategoryController>().categories.value;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeScreen * 0.04),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppTheme.secondyColor,
        ),
        borderRadius: BorderRadius.circular(sizeScreen * 0.04),
      ),
      child: DropdownButton(
        hint: Text(
          "Categoria",
          style: TextStyle(
            fontSize: sizeScreen * 0.05,
            color: Colors.white54,
          ),
        ),
        dropdownColor: AppTheme.primaryColor,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppTheme.secondyColor,
        ),
        style: TextStyle(
          fontSize: sizeScreen * 0.05,
          color: AppTheme.secondyColor,
        ),
        underline: Container(height: 0),
        borderRadius: BorderRadius.circular(sizeScreen * 0.04),
        isExpanded: true,
        value: category,
        items: categories.map((categorySelected) {
          return DropdownMenuItem(
            value: categorySelected.id,
            child: Text(categorySelected.name ?? ""),
          );
        }).toList(),
        onChanged: (int? newCategory) {
          setState(() {
            category = newCategory!;
          });
          widget.onSubmit(category!);
        },
      ),
    );
  }
}
