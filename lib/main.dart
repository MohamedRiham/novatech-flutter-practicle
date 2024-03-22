import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';
import 'provider/data.dart';

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
    Size screenSize = MediaQuery.of(context).size;
    print("Screen Width: ${screenSize.width}, Height: ${screenSize.height}");

      return MaterialApp(
          builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
                  breakpoints: const [
                    ResponsiveBreakpoint.resize(350, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(600, name: TABLET),
                    ResponsiveBreakpoint.resize(800, name: DESKTOP),
                    ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
                  ],
              ),





  theme: ThemeData( scaffoldBackgroundColor: Colors.blue[400]!,),
home: Register(),
    );

  }
}

