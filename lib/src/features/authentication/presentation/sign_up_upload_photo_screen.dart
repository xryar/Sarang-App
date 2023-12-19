import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarang_app/src/common_widgets/custom_button_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_text_button_widget.dart';
import 'package:sarang_app/src/common_widgets/logo_and_tagline_widget.dart';
import 'package:sarang_app/src/common_widgets/upload_photo_widget.dart';
import 'package:sarang_app/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:sarang_app/src/features/likes_you/domain/user_account.dart';
import 'package:sarang_app/src/features/likes_you/presentation/explore_people_screen.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/values_manager.dart';
import 'package:sarang_app/src/utils/image_picker_util.dart';

class SignUpUploadPhotoScreen extends StatefulWidget {
  static const String routeName = '/sign-up-upload-photo';
  const SignUpUploadPhotoScreen({super.key});

  @override
  State<SignUpUploadPhotoScreen> createState() =>
      _SignUpUploadPhotoScreenState();
}

class _SignUpUploadPhotoScreenState extends State<SignUpUploadPhotoScreen> {
  File? image;

  void getImageProfile(GetImageFrom source) async {
    final result = await ImagePickerUtil.getImage(source);
    if (result != null) {
      setState(() {
        image = File(result.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //menangkap argument dari sign up job and age
    UserAccount userAccount =
        ModalRoute.of(context)?.settings.arguments as UserAccount;

    return Scaffold(
      //supaya ketika user menekan sign up, user tidak bisa kembali ke page sign up lagi
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSucces) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              ExplorePeopleScreen.routeName,
              (route) => false,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppPadding.p50,
            horizontal: AppPadding.p24,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LogoAndTaglineWidget(),
                SizedBox(
                  height: AppSize.s50,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(
                            AppPadding.p24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  getImageProfile(GetImageFrom.camera);
                                },
                                icon: Icon(
                                  Icons.camera,
                                  size: AppSize.s50,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  getImageProfile(GetImageFrom.gallery);
                                },
                                icon: Icon(
                                  Icons.photo,
                                  size: AppSize.s50,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: UploadPhotoWidget(
                    image: image,
                  ),
                ),
                SizedBox(
                  height: 53.0,
                ),
                Text(
                  '${userAccount.fullname}',
                  style: getWhiteTextStyle(
                      fontSize: FontSizeManager.f22,
                      fontWeight: FontWeightManager.semiBold),
                ),
                SizedBox(
                  height: AppSize.s4,
                ),
                Text(
                  '${userAccount.age}, ${userAccount.occupation}',
                  style: getBlack60TextStyle(),
                ),
                SizedBox(
                  height: 60.0,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return CustomButtonWidget(
                      title: 'Update My Profile',
                      onTap: () {
                        if (image == null) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No Image Update'),
                            ),
                          );
                          return;
                        }
                        userAccount.imageProfile = image?.path;
                        context.read<AuthBloc>().add(
                              RegisterAuthEvent(
                                userAccount: userAccount,
                                isRegister: true,
                              ),
                            );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                CustomTextButtonWidget(
                  title: 'Skip for now',
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          RegisterAuthEvent(
                            userAccount: userAccount,
                            isRegister: true,
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
