import '../data/categories.dart';

searchCategory(id) {
  for (var category in categories) {
    if (id == category['id']) {
      return category['name'];
    }
  }
  return "Sem categoria";
}
