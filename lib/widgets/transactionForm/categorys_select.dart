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
  final categories = Get.find<CategoryController>().categories.value;
  int? category;

  @override
  void initState() {
    super.initState();
    if (widget.categoryId != null) {
      final Category categorySelected =
          categories.firstWhere((category) => category.id == widget.categoryId);
      category = categorySelected.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

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
            value: int.parse(categorySelected.id.toString()),
            child: Text(categorySelected.name!),
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
