import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';
import 'package:pet_adoption_app/utils/screen_utils/widgets/spacing_widgets.dart';

import '../../../../bloc/pet_adoption/pet_adoption_bloc.dart';
import '../../../../data/models/pet_model.dart';

class PetCardWidget extends StatelessWidget {
  const PetCardWidget({
    required this.petModel,
    this.onCardTap,
    super.key,
    this.isAdopted = false,
  });

  final PetModel petModel;
  final bool isAdopted;
  final Function(PetModel)? onCardTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: () {
        onCardTap?.call(petModel);
      },
      child: ColoredBox(
        color: colorScheme.primary.withOpacity(
          .5,
        ),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            isAdopted ? Colors.grey : Colors.transparent,
            BlendMode.saturation,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: petModel.id,
              child: CachedNetworkImage(
                  imageUrl: petModel.imageURL,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 80.vdp(),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.hdp(),
                                vertical: 8.vdp(),
                              ),
                              decoration: BoxDecoration(
                                  color: theme.secondaryHeaderColor
                                      .withOpacity(.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        petModel.name,
                                        style: theme.textTheme.titleLarge!
                                            .copyWith(
                                                color: colorScheme.primary,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 8.hdp()),
                                        padding: EdgeInsets.all(5.vdp()),
                                        decoration: BoxDecoration(
                                          color: colorScheme.background,
                                          borderRadius: BorderRadius.circular(
                                            4.vdp(),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.stars,
                                              color: colorScheme.primary,
                                              size: 12.vdp(),
                                            ),
                                            const HSpace(4),
                                            Text(petModel.character,
                                                style:
                                                    theme.textTheme.bodySmall,
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ],
                                        ),
                                      ),
                                      const HSpace(20),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Sex: ${petModel.sex}",
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        petModel.sex == "Male"
                                            ? Icons.male
                                            : Icons.female,
                                        size: 24.vdp(),
                                        color: colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocBuilder<PetAdoptionBloc, PetAdoptionState>(
                            builder: (context, state) {
                              if (state is PetAdoptionListLoadedState) {
                                return Visibility(
                                    visible: state.list
                                        .where((element) =>
                                            element.id == petModel.id)
                                        .isNotEmpty,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 8.hdp()),
                                        padding: EdgeInsets.all(16.vdp()),
                                        decoration: BoxDecoration(
                                          color: colorScheme.background,
                                          borderRadius: BorderRadius.circular(
                                            16.vdp(),
                                          ),
                                        ),
                                        child: Text(
                                          "Adopted ;)",
                                          style: theme.textTheme.headlineLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ));
                              } else {
                                return const SizedBox();
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
