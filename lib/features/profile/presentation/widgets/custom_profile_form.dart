
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:chat_app/core/widgets/custom_dialogs.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:chat_app/features/profile/presentation/manager/profile_service.dart';
import 'package:chat_app/features/profile/presentation/widgets/cusotm_text_form_fiel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomProfileForm extends StatelessWidget {
  const CustomProfileForm({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final profileService = context.read<ProfileService>();
    return Form(
      key: profileService.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            onSaved: (name) => profileService.name = name ?? "",
            label: AppStrings.name,
            initialValue: user.name,
            prefixIcon: const Icon(Icons.person, color: AppColors.green),
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            onSaved: (about) => profileService.about = about ?? "",
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
      onPressed: () => _onUpdatePressed(context),
      style: _getButtonStyle(),
      label: _getLabelText(context),
      icon: const Icon(Icons.edit, color: AppColors.white),
    );
  }

  Future<void> _onUpdatePressed(BuildContext context) async {
    final profileService = context.read<ProfileService>();
    final home = context.read<HomeService>();

    if (profileService.formKey.currentState!.validate()) {
      profileService.formKey.currentState!.save();
      final val = await profileService.updateUserProfile(user: user);

      if (val == null) {
        CustomDialogs.showSnackBar(
          context: context,
          msg: AppStrings.err,
          color: AppColors.red,
        );
      } else {
        home.user = home.user.copyWith(name: val.name, about: val.about);
        CustomDialogs.showSnackBar(
          context: context,
          msg: AppStrings.updateProfileSuc,
          color: AppColors.green,
        );
      }
    }
  }

  Text _getLabelText(BuildContext context) {
    return Text(
      AppStrings.updateProfile,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      backgroundColor: AppColors.green,
      shape: const StadiumBorder(),
    );
  }
}
