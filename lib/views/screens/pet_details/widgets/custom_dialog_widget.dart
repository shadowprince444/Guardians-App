import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';

import '../../../../utils/screen_utils/widgets/spacing_widgets.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions;
  final Function()? onOkTap;

  const CustomDialogBox({
    Key? key,
    required this.title,
    required this.descriptions,
    this.onOkTap,
  }) : super(key: key);

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final double padding = 20.vdp();
  final double avatarRadius = 45.vdp();
  late final ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    _confettiController.play();
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: padding,
              top: avatarRadius + padding,
              right: padding,
              bottom: padding),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(padding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: colorScheme.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 14.sp(),
                  color: colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const VSpace(
                22,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onOkTap?.call();
                  },
                  child: Text(
                    "Ok",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 18.sp(),
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
              backgroundColor: colorScheme.surface,
              radius: avatarRadius,
              child: Icon(
                Icons.pets,
                size: 56.vdp(),
                color: colorScheme.primary,
              )),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 40,
              maxBlastForce: 40,
              shouldLoop: false,
              colors: const [
                Colors.purple,
                Colors.green,
                Colors.blue,
                Colors.amber,
                Colors.red,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
