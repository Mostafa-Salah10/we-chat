import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_home_app_bar.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_user_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final homeSevice = context.read<HomeService>();
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(),
      appBar: CustomHomeAppBar(),
      body: StreamBuilder(
        stream: homeSevice.getAllUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(color: AppColors.green),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final queryDoc = snapshot.data!.docs;
              final List<UserModel> users =
                  queryDoc
                      .map(
                        (user) => UserModel.fromJson(
                          user.data() as Map<String, dynamic>,
                        ),
                      )
                      .toList();
              return _getUsersView(users, context);
          }
        },
      ),
    );
  }

  Widget _getUsersView(List<UserModel> users, BuildContext bx) {
    return users.isEmpty
        ? Center(
          child: Text(
            AppStrings.userConnec,
            style: Theme.of(bx).textTheme.bodyMedium,
          ),
        )
        : ListView.builder(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 1.8),
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            return CustomUserItem(userModel: users.elementAt(index));
          },
        );
  }

  FloatingActionButton _getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add_comment_rounded, color: AppColors.white),
    );
  }
}
