import '../../../data/models/products_model.dart';

abstract class RecommendState {}

class RecommendInitial extends RecommendState {}

class RecommendLoading extends RecommendState {}

class RecommendSuccess extends RecommendState {
  final List<ProductsModel> products;

  RecommendSuccess(this.products);
}

class RecommendFailure extends RecommendState {
  final String error;

  RecommendFailure(this.error);
}
