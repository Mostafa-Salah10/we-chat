import 'package:chat_app/core/constants/firebase_cons.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_user_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(),
      appBar: _getAppBarHome(context),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance
                .collection(FireBaseConstants.users)
                .snapshots(),
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
                      .map((user) => UserModel.fromJson(user.data()))
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

  AppBar _getAppBarHome(BuildContext context) {
    return AppBar(
      leading: const Icon(CupertinoIcons.home),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
      title: Text(
        AppStrings.appName,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
