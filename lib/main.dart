import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';
import 'provider/data.dart';
import 'home_page.dart';

import 'authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MyApp(),
),
);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: child!,
      ),

  theme: ThemeData( scaffoldBackgroundColor: Colors.blue[800]!,),
home: Register(),
    );

  }
}

