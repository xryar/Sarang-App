import 'package:flutter/material.dart';
import 'package:sarang_app/src/common_widgets/banner_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_button_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_text_button_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_text_field_widget.dart';
import 'package:sarang_app/src/features/authentication/presentation/sign_up_age_job_screen.dart';
import 'package:sarang_app/src/theme_manager/values_manager.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.clear();
    nameController.dispose();
    emailController.clear();
    emailController.dispose();
    passwordController.clear();
    passwordController.dispose();
    super.dispose();
  }

  String? validationInput() {
    if (nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
      return 'Name or Email or Password can\'t be empty';
    }

    if (nameController.text.length < 4 || emailController.text.length < 4 || passwordController.text.length < 4) {
      return 'Too Short, Minimum 4 characters';
    }

    //klo tidak mengandung huruf @, klo mengandung hapus tanda !
    if (!emailController.text.contains('@')) {
      return 'Email not valid without @';
    }
    
    return null;

  }

  @override
  Widget build(BuildContext context) {
    //gaperlu inisiasi warna background lagi karena udah kita buat di theme_data_manager
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p50,
          horizontal: AppPadding.p24,
        ),
        //biar lebih responsive klo design yg digunakan tidak sesuai dengan hp kita
        child: SingleChildScrollView(
          child: Column(
            children: [
              BannerWidget(),
              CustomTextFieldWidget(
                labelName: 'Complete Name',
                hintText: 'Write your name',
                controller: nameController
              ),
              CustomTextFieldWidget(
                labelName: 'Email Address',
                hintText: 'Write your email address',
                controller: emailController
              ),
              CustomTextFieldWidget(
                labelName: 'Password',
                hintText: 'Write your security',
                controller: passwordController,
                isObsecure: true,
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              CustomButtonWidget(
                title: 'Get Started',
                onTap: (){
                  final message = validationInput();
                  if (message != null) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => SignUpAgeJobScreen(
                        fullname: nameController.text, 
                        email: emailController.text, 
                        password: passwordController.text,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              CustomTextButtonWidget(
                title: 'Sign In to My Account', 
                onPressed: (){}
              ),
            ],
            ),
        ),
       ),
    );
  }
}