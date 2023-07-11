import 'package:flutter/material.dart';

class PetCategoryWidget extends StatelessWidget {
  const PetCategoryWidget({
    super.key,
    required this.title,
    this.count = 0,
    this.isSelected = false,
  });

  final String title;
  final int count;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final cardColor = isSelected ? colorScheme.primary : colorScheme.surface;
    // final iconColor = isSelected ? colorScheme.surface : colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Chip(
          avatar: Icon(
            Icons.pets,
            color: cardColor,
          ),
          label: Text(
            "${title.toUpperCase()}($count)",
            style: theme.textTheme.bodySmall!.copyWith(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
