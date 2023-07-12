import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/data/models/adoption_history.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';
import 'package:pet_adoption_app/utils/screen_utils/widgets/spacing_widgets.dart';

import '../../../../utils/functions.dart';

class AdoptedPetWidget extends StatelessWidget {
  const AdoptedPetWidget({
    required this.petHistoryModel,
    super.key,
  });

  final AdoptionHistory petHistoryModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return ColoredBox(
      color: colorScheme.primary.withOpacity(
        .5,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
            imageUrl: petHistoryModel.imageUrl,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 120.vdp(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.hdp(),
                      vertical: 8.vdp(),
                    ),
                    decoration: BoxDecoration(
                        color: theme.secondaryHeaderColor.withOpacity(.5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              petHistoryModel.name,
                              style: theme.textTheme.titleLarge!.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                            "Adopted on : ${formatDateTime(petHistoryModel.adoptedTime)}",
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        Row(
                          children: [
                            Text(
                              "Sex: ${petHistoryModel.sex}",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              petHistoryModel.sex == "Male"
                                  ? Icons.male
                                  : Icons.female,
                              size: 24.vdp(),
                              color: colorScheme.primary,
                            ),
                            const HSpace(8),
                            Text(
                              "Age:${petHistoryModel.age} year",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
