import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/themes/app_theme.dart';
import 'features/splash/presentation/pages/splash_page.dart'; // Add this import

class SeclobApp extends StatelessWidget {
  const SeclobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Seclob Reseller',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:
                const SplashPage(), // Changed from OnboardingPage to SplashPage
          );
        },
      ),
    );
  }
}
