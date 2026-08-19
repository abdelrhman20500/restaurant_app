import '../../../data/models/products_model.dart';

abstract class BestSellerState {}

//best seller states
class BestSellerInitial extends BestSellerState {}

class BestSellerLoading extends BestSellerState {}

class BestSellerSuccess extends BestSellerState {
  final List<ProductsModel> products;

  BestSellerSuccess(this.products);
}

class BestSellerFailure extends BestSellerState {
  final String error;

  BestSellerFailure(this.error);
}
