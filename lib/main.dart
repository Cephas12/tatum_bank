import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/dependencies.dart';
import 'providers/auth_provider.dart';
import 'nav/login_screen.dart';
import 'nav/screen3.dart';
import 'nav/screen1.dart';
import 'dashboards/dashboard_screen.dart';
import 'dashboards/account_information_screen.dart';

void main() {
  final deps = Dependencies.resolve();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(deps.authRepository)..bootstrap(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Demo',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const Screen3(),
        '/home': (_) => const DashboardScreen(),
        '/profile': (_) => const AccountInformationScreen(),
      },
      home: Consumer<AuthProvider>(
        builder: (_, auth, _) =>
            auth.isLoggedIn ? const DashboardScreen() : const Screen1(),
      ),
    );
  }
}


