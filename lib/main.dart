// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordBox',
      debugShowCheckedModeBanner: false, // <-- DEBUG yazısını kaldırır
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Provider.of<AuthService>(context, listen: false).autoLogin(),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
            : Consumer<AuthService>(
          builder: (ctx, auth, _) => auth.isAuth
              ? const HomeScreen()
              : const AuthScreen(),
        ),
      ),
      routes: {
        '/auth': (ctx) => const AuthScreen(),
      },
    );
  }
}
