import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/profile/presentation/widgets/cusotm_text_form_fiel.dart';
import 'package:flutter/material.dart';

class CustomProfileForm extends StatelessWidget {
  const CustomProfileForm({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            label: AppStrings.name,
            initialValue: user.name,
            prefixIcon: const Icon(Icons.person, color: AppColors.green),
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            label: AppStrings.about,
            initialValue: user.about,
            prefixIcon: const Icon(Icons.info_outline, color: AppColors.green),
          ),
          VerticalSpace(height: 4),

          _getUpdateButton(context),
        ],
      ),
    );
  }

  ElevatedButton _getUpdateButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},

      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: AppColors.green,
        shape: StadiumBorder(),
      ),
      label: Text(
        AppStrings.updateProfile,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      icon: const Icon(Icons.edit, color: AppColors.white),
    );
  }
}
