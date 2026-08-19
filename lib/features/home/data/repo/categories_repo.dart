import 'package:dartz/dartz.dart';
import 'package:restaurant_app/features/home/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoriesRepo {
  final SupabaseClient supabase;

  CategoriesRepo(this.supabase);

  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response =
          await supabase.from('categories').select().order('created_at');
      final categories = (response as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList();
      return Right(categories);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
