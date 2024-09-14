import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_riverpod/routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';

const String envFirebaseEmulatorIp = String.fromEnvironment(
  'FIREBASE_EMULATOR_IP',
  defaultValue: '',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) await _connectToFirebaseEmulator();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future _connectToFirebaseEmulator() async {
  String localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  if (envFirebaseEmulatorIp.isNotEmpty) {
    /// use the provided IP address for the emulator
    /// this is useful when running the app on a physical device
    localHostString = envFirebaseEmulatorIp;
  }
  debugPrint('Using Firebase Emulator, connecting to $localHostString');

  await FirebaseAuth.instance.useAuthEmulator(localHostString, 9099);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Riverpod Authenticated Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigoAccent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        useMaterial3: false,
      ),
    );
  }
}
