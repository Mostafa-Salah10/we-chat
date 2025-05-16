import 'package:chat_app/core/functions/custom_navigator.dart';
import 'package:chat_app/core/repo/global_repo.dart';
import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final homeSevice = context.read<HomeService>();
    return _getAppBar(homeSevice, context);
  }

  AppBar _getAppBar(HomeService homeSevice, BuildContext context) {
    return AppBar(
      leading: const Icon(CupertinoIcons.home),
      actions: _getAppBarActions(homeSevice),
      title:
          homeSevice.isSearch
              ? TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: AppStrings.name,
                ),
                autofocus: true,
                onChanged: (value) {
                  homeSevice.search(value);
                },
              )
              : Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
    );
  }

  List<Widget> _getAppBarActions(HomeService homeSevice) {
    return [
      homeSevice.isSearch
          ? IconButton(
            onPressed: () {
              homeSevice.update(false);
            },
            icon: const Icon(CupertinoIcons.clear_circled_solid),
          )
          : IconButton(
            onPressed: () {
              homeSevice.update(true);
            },
            icon: const Icon(Icons.search),
          ),
      _getPubupMenu(),
    ];
  }

  PopupMenuButton<dynamic> _getPubupMenu() {
    return PopupMenuButton(
      color: AppColors.offWhite,
      offset: Offset(0, 53),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              GlobalRepo.signOut().then((value) {
                customPushAndRemoveAll(context, route: AppRoutes.signInScreen);
              });
            },
            child: Center(child: Text(AppStrings.logout)),
          ),
          PopupMenuItem(
            onTap: () {
              final home = context.read<HomeService>();
              customPush(
                context,
                route: AppRoutes.profileScreen,
                argument: home.user,
              );
            },
            child: Center(child: Text(AppStrings.settings)),
          ),
        ];
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
