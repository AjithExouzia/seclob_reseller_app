import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seclob_app/core/utils/screensize.dart';
import '../../../../../core/providers/theme_provider.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../auth/presentation/pages/sign_in_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isNotificationEnabled = false;

  void _showNotificationSnackBar(bool isEnabled) {
    final message = isEnabled ? 'Notification On' : 'Notification Off';
    final backgroundColor = isEnabled ? Colors.green : Colors.orange;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppTheme.darkSurfaceColor : AppTheme.surfaceColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDarkMode ? AppTheme.darkTextPrimary : Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(context, isDarkMode),
          const SizedBox(height: 24),
          _buildAccountSection(context, themeProvider, isDarkMode),
          const SizedBox(height: 24),
          _buildLogoutButton(context, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDarkMode) {
    return Card(
      elevation: 0,
      color: AppTheme.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: screenWidth(context, dividedBy: 8),
              height: screenHeight(context, dividedBy: 15),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey),
              child: Image(image: AssetImage('assets/images/Avatar.png')),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'daniel',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.surfaceColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'daniei93@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.surfaceColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSection(
      BuildContext context, ThemeProvider themeProvider, bool isDarkMode) {
    return Card(
      elevation: 0,
      color: isDarkMode ? AppTheme.darkSurfaceColor : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? AppTheme.darkTextPrimary : Colors.black,
              ),
            ),
          ),
          _buildListTile(
            title: 'Profile',
            iconPath: 'assets/icons/profile_icon.png',
            isDarkMode: isDarkMode,
          ),
          _buildListTile(
            title: 'Darkmode',
            iconPath: 'assets/icons/darkmode_icon.png',
            trailing: _buildCustomSwitch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.setTheme(value);
              },
            ),
            isDarkMode: isDarkMode,
          ),
          _buildListTile(
            title: 'Notification',
            iconPath: 'assets/icons/notification_icon.png',
            trailing: _buildCustomSwitch(
              value: _isNotificationEnabled,
              onChanged: (value) {
                setState(() {
                  _isNotificationEnabled = value;
                });
                _showNotificationSnackBar(value);
              },
            ),
            isDarkMode: isDarkMode,
          ),
          _buildListTile(
            title: 'Bank Account',
            iconPath: 'assets/icons/bank.png',
            isDarkMode: isDarkMode,
          ),
          _buildListTile(
            title: 'Help & Support',
            iconPath: 'assets/icons/help&supporticon.png',
            isDarkMode: isDarkMode,
          ),
          _buildListTile(
            title: 'Consumer policies',
            iconPath: 'assets/icons/consumer_policies_icon.png',
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: screenWidth(context, dividedBy: 8),
        height: screenHeight(context, dividedBy: 32),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.5),
          color: value ? AppTheme.primaryColor : Color(0xFFD1D1D6),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String iconPath,
    Widget? trailing,
    required bool isDarkMode,
  }) {
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        child: Image.asset(
          iconPath,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
          color: isDarkMode ? AppTheme.darkTextPrimary : null,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? AppTheme.darkTextPrimary : Colors.black,
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.chevron_right,
            color: isDarkMode ? AppTheme.darkTextSecondary : Colors.grey[600],
          ),
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isDarkMode) {
    return Card(
      elevation: 0,
      color: isDarkMode ? AppTheme.darkSurfaceColor : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 24,
          height: 24,
          child: Image.asset(
            'assets/icons/logout.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            color: Colors.red[600],
          ),
        ),
        title: Text(
          'Log out',
          style: TextStyle(
            color: Colors.red[600],
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        onTap: () {
          _showLogoutBottomSheet(context, isDarkMode);
        },
      ),
    );
  }

  void _showLogoutBottomSheet(BuildContext context, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppTheme.darkSurfaceColor : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppTheme.darkTextSecondary
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icons/Featured icon.png',
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'log out?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppTheme.darkTextPrimary : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? AppTheme.darkTextSecondary : Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                            color: isDarkMode
                                ? AppTheme.darkTextSecondary.withOpacity(0.3)
                                : Colors.grey[300]!),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: isDarkMode
                              ? AppTheme.darkTextPrimary
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInPage(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Log out',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
