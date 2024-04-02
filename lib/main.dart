import 'dart:ui';

import 'package:edu/providers/crypto_data_provider.dart';
import 'package:edu/providers/market_provider.dart';
import 'package:edu/providers/sing_up_provider.dart';
import 'package:edu/providers/theme_provider.dart';
import 'package:edu/ui/global_widget/theme_switcher.dart';
import 'package:edu/ui/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CryptoDataProvider()),
        ChangeNotifierProvider(create: (context) => MarketViewProvider()),
        ChangeNotifierProvider(create: (context) => SingUpProvider()),
      ],
      child: const MyMaterialApp(),
    ),
  );
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(

          locale: Locale("en"),
          themeMode: themeProvider.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: MainWrapper(),
          ),
        );
      },
    );
  }
}
