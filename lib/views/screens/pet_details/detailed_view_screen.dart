import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';
import 'package:pet_adoption_app/utils/screen_utils/widgets/responsive_safe_area.dart';
import 'package:pet_adoption_app/utils/screen_utils/widgets/spacing_widgets.dart';
import 'package:pet_adoption_app/views/screens/pet_details/widgets/custom_dialog_widget.dart';

import '../../../bloc/pet_adoption/pet_adoption_bloc.dart';
import '../../../data/models/pet_model.dart';
import 'widgets/pet_details_grid_widget.dart';
import 'widgets/pet_image_details_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({required this.petModel, super.key});

  final PetModel petModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> itemList = {
      "Age": widget.petModel.age.toString(),
      "Price": widget.petModel.price.toString(),
      "Character": widget.petModel.character,
      "Type": widget.petModel.type,
      "Sex": widget.petModel.sex,
      "Color": widget.petModel.color,
    };
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      body: ResponsiveSafeArea(
          builder: (context, size) => ColoredBox(
                color: colorScheme.background,
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PetImageDetailsWidget(
                        petModel: widget.petModel,
                        colorScheme: colorScheme,
                        size: size,
                      ),
                      const VSpace(60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.petModel.name,
                          style: theme.textTheme.headlineLarge!.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const VSpace(40),
                      PetDetailsGridWidget(
                          itemList: itemList,
                          colorScheme: colorScheme,
                          theme: theme),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.all(
                          16.vdp(),
                        ),
                        child: BlocListener<PetAdoptionBloc, PetAdoptionState>(
                          listener: (context, state) {
                            if (state is PetAdoptedState) {
                              if (mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomDialogBox(
                                    title: 'Success',
                                    descriptions:
                                        "You've now adopted ${widget.petModel.name}",
                                    onOkTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                              } else if (state is PetAdoptionLoadingState) {}
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: FilledButton(
                              onPressed: () {
                                if (!widget.petModel.isAdopted) {
                                  BlocProvider.of<PetAdoptionBloc>(context)
                                      .add(AdoptPetEvent(widget.petModel));
                                }
                              },
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                widget.petModel.isAdopted
                                    ? "Already Adopted"
                                    : "Adopt Me",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: colorScheme.background),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
