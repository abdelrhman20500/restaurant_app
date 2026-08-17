import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/cubit/home_cubit/home_cubit.dart';
import '../presentation/cubit/home_cubit/home_state.dart';
import 'best_seller_card.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, BestSellerState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        if (state is BestSellerLoading) {
          return const SizedBox(
            height: 105,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is BestSellerFailure) {
          return SizedBox(
            height: 105,
            child: Center(
              child: Text(
                state.error,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (state is BestSellerSuccess && state.products.isEmpty) {
          return const SizedBox(
            height: 105,
            child: Center(
              child: Text('No best sellers found'),
            ),
          );
        }

        return SizedBox(
          height: 105,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: state is BestSellerSuccess ? state.products.length : 0,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
            itemBuilder: (context, index) {
              final product = cubit.products[index];

              return BestSellerCard(
                imagePath: product.imageUrl,
                price: '\$${product.price.toStringAsFixed(2)}',
              );
            },
          ),
        );
      },
    );
  }
}
