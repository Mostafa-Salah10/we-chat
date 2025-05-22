
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_home_app_bar.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_user_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  @override
  void initState() {
    _listeToTest(true);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _listeToTest(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _listeToTest(false);
    } else if (state == AppLifecycleState.resumed) {
      _listeToTest(true);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeService>(
      builder:
          (_, value, _) => Scaffold(
            floatingActionButton: _getFloatingActionButton(),
            appBar: CustomHomeAppBar(),
            body: StreamBuilder(
              stream: value.getAllUsers(),
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
                    value.users.clear();
                    value.users = List.from(users);
                    return _getUsersView(users, value.filterList, context);
                }
              },
            ),
          ),
    );
  }

  Widget _getUsersView(
    List<UserModel> users,
    List<UserModel> filterList,
    BuildContext bx,
  ) {
    final homeSevice = bx.read<HomeService>();

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
          itemCount: homeSevice.isSearch ? filterList.length : users.length,
          itemBuilder: (context, index) {
            homeSevice.userImageFile = null;
            homeSevice.loadImageFromCache(
              userId:
                  homeSevice.isSearch
                      ? filterList.elementAt(index).id
                      : users.elementAt(index).id,
            );
            return CustomUserItem(
              userModel:
                  homeSevice.isSearch
                      ? filterList.elementAt(index)
                      : users.elementAt(index),
            );
          },
        );
  }

  FloatingActionButton _getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add_comment_rounded, color: AppColors.white),
    );
  }

  void _listeToTest(bool val) {
    final home = context.read<HomeService>();
    home.updateUserState(isOnline: val);
  }
}
