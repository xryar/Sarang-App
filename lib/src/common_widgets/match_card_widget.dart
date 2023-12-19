import 'package:flutter/material.dart';
import 'package:sarang_app/src/common_widgets/glass_card_widget.dart';
import 'package:sarang_app/src/features/authentication/domain/user.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';
import 'package:sarang_app/src/theme_manager/values_manager.dart';

class MatchCardWidget extends StatelessWidget {
  const MatchCardWidget({
      super.key,
      required this.user
    });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          //tidak memakai height karena tingginya sudah diatur oleh expanded
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                user.imagePath,
              ),
            ),
            border: Border.all(
              width: 10.0,
              color: ColorManager.secondary,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            borderRadius: BorderRadius.circular(AppSize.s70)
          ),
        ),
        GlassCardWidget(
          user: user,
        ),
      ],
    );
  }
}