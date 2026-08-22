import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/cubit/categories_cubit/categories_cubit.dart';
import '../presentation/cubit/categories_cubit/categories_state.dart';
import 'categories_card.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final cubit = context.read<CategoriesCubit>();
        if (state is CategoriesLoading) {
          return const SizedBox(
            height: 105,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is CategoriesFailure) {
          return SizedBox(
            height: 105,
            child: Center(
              child: Text(
                state.error,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          );
        }

        return SizedBox(
          height: 105,
          child: Row(
            children: List.generate(
              cubit.categories.length,
              (index) {
                final category = cubit.categories[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      cubit.selectCategory(index);
                    },
                    child: CategoryCard(
                      name: category.name,
                      imageUrl: category.imageUrl,
                      isSelected: cubit.selectedIndex == index,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
