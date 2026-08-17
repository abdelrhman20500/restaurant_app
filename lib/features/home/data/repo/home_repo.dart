import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/products_model.dart';

class HomeRepo {
  final SupabaseClient supabase;

  HomeRepo(this.supabase);

  Future<Either<String, List<ProductsModel>>> getBestSellers() async {
    try {
      final response =
          await supabase.from('products').select().eq('is_best_seller', true);
      print('BEST SELLERS RESPONSE: $response');
      final products = (response as List)
          .map((product) => ProductsModel.fromJson(product))
          .toList();
      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<ProductsModel>>> getRecommended() async {
    try {
      final response =
          await supabase.from('products').select().eq('is_recommended', true);
      print('BEST SELLERS RESPONSE: $response');
      final products = (response as List)
          .map((product) => ProductsModel.fromJson(product))
          .toList();
      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
