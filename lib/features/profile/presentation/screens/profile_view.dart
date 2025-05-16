import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/profile/presentation/widgets/custom_profile_form.dart';
import 'package:chat_app/features/profile/presentation/widgets/custom_profile_image.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.profile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.06,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                VerticalSpace(height: 5),
                CustomProfileImage(image: user.image),
                VerticalSpace(height: 3),
                _getEmailWidget(context),
                VerticalSpace(height: 5),
                CustomProfileForm(user: user),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _getEmailWidget(BuildContext context) {
    return Text(
      maxLines: 1,
      user.email,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(color: AppColors.blackShade54),
    );
  }
}
