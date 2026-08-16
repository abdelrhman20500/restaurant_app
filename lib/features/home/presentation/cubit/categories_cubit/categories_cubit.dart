import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/category_model.dart';
import '../../../data/repo/categories_repo.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.categoriesRepo) : super(CategoriesInitial());

  final CategoriesRepo categoriesRepo;

  List<CategoryModel> categories = [];

  int selectedIndex = 0;

  Future<void> getCategories() async {
    emit(CategoriesLoading());

    final response = await categoriesRepo.getCategories();

    response.fold(
      (error) {
        emit(CategoriesFailure(error));
      },
      (data) {
        categories = data;

        emit(CategoriesSuccess(categories));
      },
    );
  }

  void selectCategory(int index) {
    selectedIndex = index;

    emit(CategoriesChanged());
  }
}
