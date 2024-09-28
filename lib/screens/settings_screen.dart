import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: const Text('Chế độ tối'),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          const Divider(),
          if (authService.isLoggedIn) ...[
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Người dùng'),
              subtitle: Text(authService.currentUser ?? 'Unknown User'),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: const Text('Đăng xuất'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Xác nhận'),
                      content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () {
                            authService.logout();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          child: const Text('Đăng xuất'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
