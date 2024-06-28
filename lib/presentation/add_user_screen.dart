import 'package:flutter/material.dart';
import 'package:loggy_administrator/model/line.dart';
import 'package:loggy_administrator/model/user.dart';
import 'package:loggy_administrator/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String selectedLine = 'Line 1';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLines();
  }

  void fetchLines() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).fetchLines();
      final lines = Provider.of<UserProvider>(context, listen: false).lines;

      setState(() {
        isLoading = false;
        if (lines.isNotEmpty) {
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
        title: const Text('Add User'),
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
            FilledButton.tonal(
              onPressed: () {
                if (passwordController.text == confirmPasswordController.text) {
                  final user = User(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    line: selectedLine,
                  );
                  Provider.of<UserProvider>(context, listen: false).addUser(user);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User added successfully')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match')),
                  );
                }
              },
              child: const Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
