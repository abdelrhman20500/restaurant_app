import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/products_model.dart';
import '../../../data/repo/home_repo.dart';
import 'recommend_state.dart';

class RecommendCubit extends Cubit<RecommendState> {
  final HomeRepo homeRepo;
  List<ProductsModel> products = [];

  RecommendCubit({required this.homeRepo}) : super(RecommendInitial());

  Future<void> getRecommended() async {
    emit(RecommendLoading());
    final response = await homeRepo.getRecommended();
    response.fold(
      (error) {
        emit(RecommendFailure(error));
      },
      (data) {
        products = data;
        emit(RecommendSuccess(products));
      },
    );
  }
}
