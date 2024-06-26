import 'package:flutter/material.dart';
import 'package:loggy_administrator/presentation/login_screen.dart';
import 'package:loggy_administrator/presentation/signup_screen.dart';
import 'package:loggy_administrator/presentation/users_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/users': (context) => UsersListScreen(),
      },

      home: LoginScreen(),
    );
  }
}
