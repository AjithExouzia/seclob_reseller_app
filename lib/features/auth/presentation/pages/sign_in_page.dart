import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/utils/screensize.dart';
import '../../../dashboard/presentation/pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? AppTheme.darkSurfaceColor : Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 3.4),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/images/Rectangle 141928.png'),
                      fit: BoxFit.cover)),
              child: Padding(
                padding:
                    EdgeInsets.only(left: screenWidth(context, dividedBy: 18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight(context, dividedBy: 12.5),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/app_logo.svg',
                          width: screenWidth(context, dividedBy: 20),
                          height: screenHeight(context, dividedBy: 20),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        const Text(
                          'seclob',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 32),
                    ),
                    const Text('Welcome back!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const Text(
                      'Welcome back to your workspace.',
                      style: TextStyle(color: Colors.white, fontSize: 15.5),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildInputField(
                'Enter email',
                'assets/icons/email_icon.svg',
                controller: _emailController,
                validator: _validateEmail,
                isDarkMode: isDarkMode,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context, dividedBy: 17)),
              child: _buildInputField(
                'Enter password',
                'assets/icons/password_icon.svg',
                isPassword: true,
                controller: _passwordController,
                validator: _validatePassword,
                isDarkMode: isDarkMode,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: screenWidth(context, dividedBy: 1.8),
                ),
                Text(
                  'Forget password ?',
                  style: TextStyle(
                      fontSize: 14.5,
                      color:
                          isDarkMode ? AppTheme.darkTextPrimary : Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context, dividedBy: 17)),
              child: _buildSignInButton(),
            ),
            const Spacer(),
            Text(
              'Or Log in with',
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode ? AppTheme.darkTextPrimary : Colors.black,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/google_icon.svg',
                  width: screenWidth(context, dividedBy: 30),
                  height: screenHeight(context, dividedBy: 30),
                ),
                const SizedBox(
                  width: 25,
                ),
                SvgPicture.asset(
                  'assets/icons/facebook_icon.svg',
                  width: screenWidth(context, dividedBy: 30),
                  height: screenHeight(context, dividedBy: 30),
                ),
                const SizedBox(
                  width: 25,
                ),
                SvgPicture.asset(
                  'assets/icons/apple-logo-svgrepo-com.svg',
                  width: screenWidth(context, dividedBy: 25),
                  height: screenHeight(context, dividedBy: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            _buildSignUpPrompt(isDarkMode),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String hint,
    String svgPath, {
    bool isPassword = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
    bool isDarkMode = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: TextStyle(
        color: isDarkMode ? AppTheme.darkTextPrimary : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: isDarkMode
                ? AppTheme.darkTextSecondary
                : Colors.black.withOpacity(0.3)),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            svgPath,
            width: 20,
            height: 20,
            color: AppTheme.primaryColor,
          ),
        ),
        filled: isDarkMode,
        fillColor: isDarkMode ? AppTheme.darkSurfaceColor : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor.withOpacity(0.8),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Log In',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Widget _buildSignUpPrompt(bool isDarkMode) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
              color: isDarkMode ? AppTheme.darkTextPrimary : Colors.black,
              fontSize: 15),
          children: [
            TextSpan(text: "Don't have an account ? "),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: AppTheme.primaryColor.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
