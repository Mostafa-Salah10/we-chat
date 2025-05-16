import 'package:chat_app/features/home/data/repo/home_repo.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:chat_app/features/profile/data/repo/profile_repo.dart';
import 'package:chat_app/features/profile/presentation/manager/profile_service.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo.dart';
import 'package:chat_app/features/auth/presentation/manager/auth_service.dart';

List<SingleChildWidget> get getProviders {
  return [
    ChangeNotifierProvider(create: (_) => AuthService(authRepo: AuthRepo())),
    ChangeNotifierProvider(create: (_) => HomeService(homeRepo: HomeRepo())),
    ChangeNotifierProvider(
      create: (_) => ProfileService(profileRepo: ProfileRepo()),
    ),
  ];
}
