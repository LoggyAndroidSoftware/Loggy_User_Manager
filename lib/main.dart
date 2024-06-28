import 'package:flutter/material.dart';
import 'package:loggy_administrator/model/user.dart';
import 'package:loggy_administrator/presentation/add_user_screen.dart';
import 'package:loggy_administrator/presentation/login_screen.dart';
import 'package:loggy_administrator/presentation/signup_screen.dart';
import 'package:loggy_administrator/presentation/users_list_screen.dart';
import 'package:loggy_administrator/presentation/edit_user_screen.dart';
import 'package:loggy_administrator/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) =>  LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/add_user': (context) => const AddUserScreen(),
          '/users_list': (context) => const UsersListScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/edit_user') {
            final user = settings.arguments as User;
            return MaterialPageRoute(
              builder: (context) {
                return EditUserScreen(user: user);
              },
            );
          }
          return null;
        },
      ),
    );
  }
}
