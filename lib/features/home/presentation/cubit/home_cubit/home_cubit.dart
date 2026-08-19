import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/products_model.dart';
import '../../../data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<BestSellerState> {
  final HomeRepo homeRepo;
  List<ProductsModel> products = [];

  HomeCubit({required this.homeRepo}) : super(BestSellerInitial());

  Future<void> getBestSellers() async {
    emit(BestSellerLoading());
    final response = await homeRepo.getBestSellers();
    response.fold(
      (error) {
        emit(BestSellerFailure(error));
      },
      (data) {
        products = data;
        emit(BestSellerSuccess(products));
      },
    );
  }
}
