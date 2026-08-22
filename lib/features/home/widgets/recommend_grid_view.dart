import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/cubit/recommend_cubit/recommend_cubit.dart';
import '../presentation/cubit/recommend_cubit/recommend_state.dart';
import 'recommended_card.dart';

class RecommendGridView extends StatelessWidget {
  const RecommendGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendCubit, RecommendState>(
      builder: (context, state) {
        final cubit = context.read<RecommendCubit>();
        if (state is RecommendLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(
                color: Color(0xFFE95425),
              ),
            ),
          );
        }

        if (state is RecommendFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (state is RecommendSuccess && state.products.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('No recommendations found'),
            ),
          );
        }

        final productsToShow = cubit.products;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: productsToShow.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final product = productsToShow[index];
            return RecommendCard(
              product: product,
            );
          },
        );
      },
    );
  }
}
