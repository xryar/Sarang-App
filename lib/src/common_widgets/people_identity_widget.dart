import 'package:flutter/material.dart';
import 'package:sarang_app/src/features/authentication/domain/user.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/values_manager.dart';

class PeopleIdentityWidget extends StatelessWidget {
  const PeopleIdentityWidget({
    super.key,
    required this.user
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${user.fullName}',
            style: getWhiteTextStyle(
              fontSize: FontSizeManager.f28,
              fontWeight: FontWeightManager.semiBold,
            ),
          ),
          Text(
            '${user.age}, ${user.occupation}',
            style: getBlackTextStyle(),
          ),
          SizedBox(
            height: AppSize.s16,
          ),
          Text(
            user.description,
            style: getWhiteTextStyle(),
          ),
          SizedBox(
            height: AppSize.s16,
          )
        ],
      ),
    );
  }
}