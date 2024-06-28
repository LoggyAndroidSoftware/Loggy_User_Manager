import 'package:flutter/material.dart';
import 'package:loggy_administrator/model/user.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final User user = User(
  //   id: 1,
  //   username: 'john.doe',
  //   role: 'admin',
  //   profile: Profile(
  //     id: 1,
  //     firstname: 'John',
  //     lastname: 'Doe',
  //     email: 'john@gmail.com',
  //     genre: 'male',
  //     birthdate: '1990-01-01',
  //     address: '123 Main St',
  //   ),
  // );

  final User user = User(name: 'John Doe', email: 'john@gmail.com' , password: 'root', line: '1');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 100.0,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () {
                String email = emailController.text;
                String password = passwordController.text;
                //validar  que el correo sea correcta con el usuario
                if (email == user.email && password == 'root') {
                  Navigator.pushNamed(context, '/users_list');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text('Usuario incorrecto'),
                      action: SnackBarAction(
                        label: 'Cerrar',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Signup'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
