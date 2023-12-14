import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/screen_size.dart';
import '../utils/open_form.dart';
import '../../themes/app_theme.dart';
import '../controllers/categoryController/category_controller.dart';
import '../../views/category_form.dart';
import '../../widgets/categoriesPage/category_tile.dart';
import '../../widgets/custom/empty_list.dart';
import '../../widgets/custom/page_base_structure.dart';

class CategoriesPage extends GetView<CategoryController> {
  const CategoriesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);
    return PageBaseStructure(
      title: 'Categorias',
      actions: [
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            size: 27,
          ),
          onPressed: () => openForm(CategoryForm()),
        )
      ],
      child: Obx(() {
        return controller.categories.isEmpty
            ? EmptyList(
                imageSize: sizeScreen * 0.2,
                fontSize: sizeScreen * 0.04,
                color: AppTheme.secondyColor,
              )
            : ListView.builder(
                itemCount: controller.categories.length,
                itemBuilder: (ctx, i) => CategoryTile(
                  category: controller.categories.elementAt(i),
                ),
              );
      }),
    );
  }
}
