import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';

class AdoptedBadgeWidget extends StatelessWidget {
  const AdoptedBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.background.withOpacity(.75),
        borderRadius: BorderRadius.circular(5.vdp()),
      ),
      padding: EdgeInsets.all(16.vdp()),
      child: Text(
        "Adopted",
        style: theme.textTheme.bodyLarge!
            .copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
