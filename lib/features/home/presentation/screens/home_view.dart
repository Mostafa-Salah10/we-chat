import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_comment_rounded, color: AppColors.white),
      ),

      appBar: _getAppBarHome(context),
      body: Container(),
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
