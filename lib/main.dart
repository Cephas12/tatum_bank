import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/dependencies.dart';
import 'providers/auth_provider.dart';
import 'providers/account_provider.dart';
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
        ChangeNotifierProvider(
          create: (_) => AccountProvider(
            deps.accountRepository,
            deps.transactionRepository,
          )..bootstrap(),
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
      home: Consumer2<AuthProvider, AccountProvider>(
        builder: (_, auth, account, _) {
          if (auth.isLoggedIn) {
            // If logged in but account not yet refreshed, do it once
            if (!account.isInitialized) {
              account.refresh(auth.user.token);
            }
            return const DashboardScreen();
          }
          return const Screen1();
        },
      ),
    );
  }
}


