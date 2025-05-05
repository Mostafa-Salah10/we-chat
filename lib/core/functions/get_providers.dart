import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo.dart';
import 'package:chat_app/features/auth/presentation/manager/auth_service.dart';

List<SingleChildWidget> get getProviders {
  return [
    ChangeNotifierProvider(create: (_) => AuthService(authRepo: AuthRepo())),
  ];
}
