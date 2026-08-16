import '../../../data/models/category_model.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  CategoriesSuccess(this.categories);
}

class CategoriesFailure extends CategoriesState {
  final String error;

  CategoriesFailure(this.error);
}

class CategoriesChanged extends CategoriesState {}
