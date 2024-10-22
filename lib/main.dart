import 'package:book_app/notifiers/app_pdf_notifier.dart';
import 'package:book_app/notifiers/app_root_notifier.dart';
import 'package:book_app/notifiers/app_setting_notifier.dart';
import 'package:book_app/notifiers/app_status_notifier.dart';
import 'package:book_app/pages/home/home_page.dart';
import 'package:book_app/pages/login_page.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppSettingNotifier>(
        create: (_) => AppSettingNotifier()),
    ChangeNotifierProvider<AppStatusNotifier>(
        create: (_) => AppStatusNotifier()),
    ChangeNotifierProvider<AppPdfNotifier>(
        create: (context) => AppPdfNotifier()),
    ChangeNotifierProvider<AppRootNotifier>(
        create: (context) => AppRootNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: ThemeText().textThemes,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryC,
            elevation: 0,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 22),
          )),
      home: const HomePage(),
    );
  }
}
