import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_theme.dart';
import '../utils/screen_size.dart';
import '../widgets/selectPage/custom_button.dart';
import '../controllers/selection_controller.dart';

class SelectionPage extends GetView<SelectionController> {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizeScreen * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeScreen * 0.26,
                      child: Image(
                        image: AssetImage(
                          'assets/icons/flowcash-branco.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: sizeScreen * 0.025),
                    SizedBox(
                      height: sizeScreen * 0.07,
                      child: Image(
                        image: AssetImage(
                          'assets/images/flowcash-nome-branco.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Deseja qual tipo de armazenamento?',
                style: AppTheme.title2(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: sizeScreen * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    label: "Online",
                    height: ScreenSizes.getScreenHeightSize(context) * 0.065,
                    width: sizeScreen * 0.2,
                    onPressed: () => controller.onChoice(isOnline: true),
                  ),
                  SizedBox(width: sizeScreen * 0.03),
                  CustomButton(
                    label: "Offline",
                    height: ScreenSizes.getScreenHeightSize(context) * 0.065,
                    width: sizeScreen * 0.2,
                    onPressed: () => controller.onChoice(isOnline: false),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
