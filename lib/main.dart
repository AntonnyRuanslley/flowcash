import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:material_color_generator/material_color_generator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

import '../routes/get_page_route.dart';
import '../routes/routes_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('transactions');
  await Hive.openBox('categories');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0XFFB80099),
      ),
    );

    return GetMaterialApp(
      title: 'FlowCash',
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      getPages: GetPagesRoute.pages,
      // theme: ThemeData(
      //   primarySwatch: generateMaterialColor(
      //     color: Color(0XFFB80099),
      //   ),
      // ),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Color(0XFFB80099),
          secondary: Colors.white,
        ),
      ),
      initialRoute: RoutesNames.splashScreenPage,
    );
  }

  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'FlowCash',
  //     color: Color(0XFFB80099),
  //     localizationsDelegates: [
  //       GlobalMaterialLocalizations.delegate,
  //       GlobalWidgetsLocalizations.delegate
  //     ],
  //     locale: const Locale('pt', 'BR'),
  //     supportedLocales: [const Locale('pt', 'BR')],
  //     theme: tema.copyWith(
  //       colorScheme: tema.colorScheme.copyWith(
  //         primary: Color(0XFFB80099),
  //         secondary: Colors.white,
  //       ),
  //       appBarTheme: AppBarTheme(
  //         titleTextStyle: TextStyle(
  //           fontFamily: "OpenSans",
  //           fontSize: 19,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     home: Loading(),
  //   );
  // }
}
