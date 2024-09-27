import 'package:daily_planner/screens/home_screen.dart';
import 'package:daily_planner/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final authService = Provider.of<AuthService>(context, listen: false);
      final success = await authService.login(_email, _password);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng nhập thất bại. Vui lòng thử lại.')),
        );
      }
    }
  }
    void _loginWithSSO() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final success = await authService.loginWithSSO();
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaskListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập SSO thất bại. Vui lòng thử lại.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mật khẩu'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Đăng nhập'),
                onPressed: _submitForm,
              ),
              const SizedBox(height: 10),
              TextButton(
                child: const Text('Đăng nhập bằng SSO'),
                onPressed: () {
                  // TODO: Implement SSO login
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
