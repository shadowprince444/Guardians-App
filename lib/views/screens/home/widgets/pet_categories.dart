import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';
import 'package:pet_adoption_app/views/screens/home/widgets/pet_category_widget.dart';

import '../../../../bloc/get_paginated_pets/get_paginated_pets_bloc.dart';
import '../../../../utils/enums.dart';

class PetCategoriesWidget extends StatelessWidget {
  final TextEditingController searchTextController;
  const PetCategoriesWidget({super.key, required this.searchTextController});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style:
              theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        BlocBuilder<GetPaginatedPetListBloc, GetPaginatedPetListState>(
            builder: (context, state) {
          return SizedBox(
            height: 50.vdp(),
            child: ListView.builder(
              itemCount: PetCategory.values.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                var item = PetCategory.values[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.hdp()),
                  child: GestureDetector(
                    onTap: () {
                      searchTextController.clear();
                      BlocProvider.of<GetPaginatedPetListBloc>(context)
                          .add(GetPaginatedPetListCategoryEvent(item));
                    },
                    child: PetCategoryWidget(
                      title: item.name,
                      count: BlocProvider.of<GetPaginatedPetListBloc>(context)
                          .getCountByCategory(item),
                      isSelected:
                          BlocProvider.of<GetPaginatedPetListBloc>(context)
                              .isCurrentlySelected(item),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
