import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';
import 'package:pet_adoption_app/views/screens/home/widgets/pet_card_widget.dart';

import '../../../../data/models/pet_model.dart';
import '../../../../utils/screen_utils/widgets/spacing_widgets.dart';

class PetListingWidget extends StatelessWidget {
  const PetListingWidget({
    super.key,
    required ScrollController scrollController,
    required this.petList,
    this.isLoading = false,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<PetModel> petList;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: 8.hdp(),
      ),
      controller: _scrollController,
      itemCount: isLoading ? petList.length + 1 : petList.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const VSpace(24),
      itemBuilder: (context, index) {
        if (index == petList.length && isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final petModel = petList[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(
            40.vdp(),
          ),
          child: PetCardWidget(
            key: Key(petModel.id),
            petModel: petModel,
            onCardTap: (model) {
              //Navigate to detailed page
            },
            isAdopted: false,
          ),
        );
      },
    );
  }
}
