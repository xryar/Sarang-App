import 'package:flutter/material.dart';
import 'package:sarang_app/src/features/authentication/domain/user.dart';
import 'package:sarang_app/src/features/likes_you/presentation/people_profile_screen.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/values_manager.dart';

class PeopleLovedCardWidget extends StatelessWidget {
  const PeopleLovedCardWidget({
    super.key,
    required this.user
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(
            context, 
            PeopleProfileScreen.routeName,
            arguments: user,
          );
        },
        child: Container(
          margin: EdgeInsets.only(
            bottom: AppMargin.m18,
          ),
          decoration: BoxDecoration(
            color: ColorManager.secondary,
            borderRadius: BorderRadius.circular(AppSize.s20),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(AppPadding.p10),
            leading: Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    '${user.imagePath}',
                  ),
                ),
              ),
            ),
            title: Text(
              '${user.fullName}',
              style: getWhiteTextStyle(
                fontSize: FontSizeManager.f20,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
            subtitle: Text(
              '${user.age}, ${user.occupation}',
              style: getGray60TextStyle(),
            ),
          ),
        ),
      ),
    );
  }
}