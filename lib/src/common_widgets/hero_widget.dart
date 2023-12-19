import 'package:flutter/material.dart';
import 'package:sarang_app/src/theme_manager/assets_image_icon_manager.dart';
import 'package:sarang_app/src/theme_manager/values_manager.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 215,
      margin: EdgeInsets.symmetric(
        vertical: AppMargin.m30,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            '${AssetImageIconManager.assetPath}/hero_image.png'
          ),
        ),
      ),
    );
  }
}