import 'package:flutter/material.dart';
import 'package:loggy_administrator/model/profile.dart';
import 'package:loggy_administrator/model/user.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  //obtener lista de usuarios
  final List<User> users = [
    User(
      id: 1,
      username: 'john.doe',
      role: 'operator',
      profile: Profile(
        id: 1,
        firstname: 'John',
        lastname: 'Doe',
        email: 'john@gmail.com',
        genre: 'male',
        birthdate: '1990-01-01',
        address: '123 Main St',
      ),
    ),
    User(
      id: 2,
      username: 'marc.doe',
      role: 'operator',
      profile: Profile(
        id: 1,
        firstname: 'Marc',
        lastname: 'Doe',
        email: 'marc@gmail.com',
        genre: 'male',
        birthdate: '1990-01-01',
        address: '123 Main St',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final User user = users[index];
          return ListTile(
            title: Text('${user.profile.firstname} ${user.profile.lastname}'),
            subtitle: Text(user.profile.email),
            trailing: Text(user.role),
          );
        },
      ),
    );
  }
}
