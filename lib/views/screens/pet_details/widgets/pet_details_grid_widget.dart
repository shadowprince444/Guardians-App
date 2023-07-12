import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';

import '../../../../utils/screen_utils/widgets/spacing_widgets.dart';

class PetDetailsGridWidget extends StatelessWidget {
  const PetDetailsGridWidget({
    super.key,
    required this.itemList,
    required this.colorScheme,
    required this.theme,
  });

  final Map<String, String> itemList;
  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: itemList.keys.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var itemKey = itemList.keys.toList()[index];
          return Container(
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(
                16.vdp(),
              ),
            ),
            margin: EdgeInsets.all(4.vdp()),
            padding: EdgeInsets.all(4.vdp()),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                itemKey,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const VSpace(12),
              Text(
                itemList[itemKey]!,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            ]),
          );
        });
  }
}
