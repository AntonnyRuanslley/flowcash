import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/screen_size.dart';
import '../../themes/app_theme.dart';
import '../../controllers/transactionController/transaction_controller.dart';

class TitleTop extends GetView<TransactionController> {
  const TitleTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    return Container(
      height: sizeScreen * 0.22,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: sizeScreen * 0.01),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: AppTheme.secondyColor,
                    size: sizeScreen * 0.045,
                  ),
                  onPressed: () =>
                      controller.scaffoldKey.currentState!.openDrawer(),
                ),
                SizedBox(width: ScreenSizes.getScreenWidthSize(context) * 0.04),
                Container(
                  width: sizeScreen * 0.35,
                  child: const Image(
                    image: AssetImage(
                      'assets/images/flowcash-nome-branco.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
