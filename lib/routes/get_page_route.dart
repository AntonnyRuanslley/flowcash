import 'package:flowcash/bindings/category_binding.dart';
import 'package:flowcash/views/categories_page.dart';
import 'package:get/get.dart';

import '../routes/routes_names.dart';
import '../bindings/selection_binding.dart';
import '../bindings/splash_screen_binding.dart';
import '../bindings/transaction_binding.dart';
import '../views/selection.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';
import '../views/no_connection_page.dart';
import '../views/splash_screen_page.dart';
import '../views/transactions_list_page.dart';

class GetPagesRoute {
  static List<GetPage> pages = [
    GetPage(
      name: RoutesNames.splashScreenPage,
      page: () => const SplashScreenPage(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: RoutesNames.loginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RoutesNames.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RoutesNames.selectionPage,
      page: () => const SelectionPage(),
      binding: SelectionBinding(),
    ),
    GetPage(
      name: RoutesNames.noConnectionPage,
      page: () => const NoConnectionPage(),
    ),
    GetPage(
      name: RoutesNames.transactionsListPage,
      page: () => TransactionsListPage(),
      binding: TransactionListBinding(),
    ),
    GetPage(
      name: RoutesNames.categoriesPage,
      page: () => CategoriesPage(),
      binding: CategoryBinding(),
    )
  ];
}
