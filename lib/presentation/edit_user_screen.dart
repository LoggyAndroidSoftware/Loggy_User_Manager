import 'package:flutter/material.dart';
import 'package:loggy_administrator/model/line.dart';
import 'package:loggy_administrator/model/user.dart';
import 'package:loggy_administrator/provider/user_provider.dart';
import 'package:provider/provider.dart';

class EditUserScreen extends StatefulWidget {
  final User user;

  const EditUserScreen({super.key, required this.user});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late String selectedLine;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController(text: widget.user.password);
    confirmPasswordController = TextEditingController(text: widget.user.password);
    selectedLine = widget.user.line;
    fetchLines();
  }

  void fetchLines() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).fetchLines();
      final lines = Provider.of<UserProvider>(context, listen: false).lines;

      setState(() {
        isLoading = false;
        if (!lines.map((line) => line.name).contains(selectedLine)) {
          selectedLine = lines.first.name;
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching lines: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final lines = userProvider.lines;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
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
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedLine,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLine = newValue!;
                });
              },
              items: lines.map<DropdownMenuItem<String>>((Line line) {
                return DropdownMenuItem<String>(
                  value: line.name,
                  child: Text(line.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (passwordController.text == confirmPasswordController.text) {
                  User updatedUser = User(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    line: selectedLine,
                  );

                  await Provider.of<UserProvider>(context, listen: false).updateUser(updatedUser);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User updated successfully')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match')),
                  );
                }
              },
              child: const Text('Edit User'),
            ),
          ],
        ),
      ),
    );
  }
}
