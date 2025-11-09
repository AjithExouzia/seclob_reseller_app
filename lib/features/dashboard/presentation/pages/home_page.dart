import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../widgets/home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppTheme.darkSurfaceColor : AppTheme.surfaceColor,
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(isDarkMode),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const HomeTab();
      case 1:
        return const RevenueTab();
      case 2:
        return const HistoryTab();
      case 3:
        return const ProfilePage();
      default:
        return const HomeTab();
    }
  }

  Widget _buildBottomNavigationBar(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDarkMode ? AppTheme.darkSurfaceColor : Colors.white,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor:
            isDarkMode ? AppTheme.darkTextSecondary : AppTheme.textSecondary,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home_logo.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isDarkMode
                    ? AppTheme.darkTextSecondary
                    : AppTheme.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/home_logo.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppTheme.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/revenue_icon.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isDarkMode
                    ? AppTheme.darkTextSecondary
                    : AppTheme.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/revenue_icon.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppTheme.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Revenue',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/history_icon.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isDarkMode
                    ? AppTheme.darkTextSecondary
                    : AppTheme.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/history_icon.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppTheme.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/setting (1).svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isDarkMode
                    ? AppTheme.darkTextSecondary
                    : AppTheme.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/setting (1).svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppTheme.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class RevenueTab extends StatelessWidget {
  const RevenueTab({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.attach_money,
            size: 64,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Revenue',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:
                  isDarkMode ? AppTheme.darkTextPrimary : AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.history,
            size: 64,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            'History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:
                  isDarkMode ? AppTheme.darkTextPrimary : AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
