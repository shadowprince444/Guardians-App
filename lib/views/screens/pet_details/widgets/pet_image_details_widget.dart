import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';

import '../../../../data/models/pet_model.dart';
import '../../../widgets/adotped_badge_widget.dart';
import '../../image_preview/image_screen.dart';

class PetImageDetailsWidget extends StatelessWidget {
  const PetImageDetailsWidget({
    super.key,
    required this.colorScheme,
    required this.size,
    required this.petModel,
  });
  final Size size;
  final PetModel petModel;

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height * .33,
      child: Hero(
        tag: petModel.id,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ImagePreviewScreen(
                      imageUrl: petModel.imageURL, heroTag: petModel.id);
                },
              ),
            );
          },
          child: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  petModel.isAdopted
                      ? Colors.grey.withOpacity(.75)
                      : Colors.transparent,
                  BlendMode.saturation,
                ),
                child: CachedNetworkImage(
                    imageUrl: petModel.imageURL,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              petModel.isAdopted
                  ? const Positioned.fill(
                      child: Center(child: AdoptedBadgeWidget()),
                    )
                  : const SizedBox.shrink(),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    height: 80.vdp(),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.background.withOpacity(.5),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: colorScheme.primary,
                      size: 56.vdp(),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
