import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_user_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<QueryDocumentSnapshot<Map<String, dynamic>>> users =
                snapshot.data!.docs;

            print("************ User Model *******************");
            print(users.first.data());
            print("************ User Model *******************");
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockHeight * 1.8,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return CustomUserItem();
            },
          );
        },
      ),
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
