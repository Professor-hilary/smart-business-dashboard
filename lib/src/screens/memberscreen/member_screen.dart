import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Theme.of(context).brightness != Brightness.dark
                    ? Colors.black12
                    : Colors.white12,
              ),
            ),
            color: Colors.transparent,
          ),
          child: const MemberManagementHome(),
        ),
      ),
    );
  }
}

class MemberManagementHome extends StatelessWidget {
  const MemberManagementHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Member Management System')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemberRegistration()),
                );
              },
              child: const Text('Member Registration'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileManagement()),
                );
              },
              child: const Text('Profile Management'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const RoleAssignment();
                  }),
                );
              },
              child: const Text('Role Assignment'),
            ),
          ],
        ),
      ),
    );
  }
}

class MemberRegistration extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  MemberRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Member Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: RequiredValidator(
                  errorText: 'Name is required',
                ).call,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Email is required'),
                  EmailValidator(errorText: 'Enter a valid email address'),
                ]).call,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: RequiredValidator(
                  errorText: 'Password is required',
                ).call,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Member Registered Successfully'),
                      ),
                    );
                  }
                },
                child: const Text('Register Member'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileManagement extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ProfileManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile Updated Successfully')),
                );
              },
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleAssignment extends StatelessWidget {
  const RoleAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> roles = ['Admin', 'Member', 'Moderator'];
    String? selectedRole;

    return Scaffold(
      appBar: AppBar(title: const Text('Role Assignment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Assign Role to Member',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              hint: const Text('Select Role'),
              value: selectedRole,
              onChanged: (newValue) => selectedRole = newValue,
              items: roles.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedRole != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Role Assigned: $selectedRole')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a role first')),
                  );
                }
              },
              child: const Text('Assign Role'),
            ),
          ],
        ),
      ),
    );
  }
}
