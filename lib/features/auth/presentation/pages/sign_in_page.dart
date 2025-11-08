import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      return 'Please enter your email or username';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');

    if (!emailRegex.hasMatch(value) && !usernameRegex.hasMatch(value)) {
      return 'Please enter a valid email or username';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 3.4),
              decoration: BoxDecoration(
                  color: Colors.red,
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
                        Text(
                          'seclob',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 32),
                    ),
                    Text('Welcome back!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(
                      'Welcome back to your workspace.',
                      style: TextStyle(color: Colors.white, fontSize: 15.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildInputField('Email or Username', Icons.person_outline,
                  controller: _emailController, validator: _validateEmail),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context, dividedBy: 17)),
              child: _buildInputField('Password', Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                  validator: _validatePassword),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: screenWidth(context, dividedBy: 1.7),
                ),
                Text(
                  'Forgot password ?',
                  style: TextStyle(fontSize: 13, color: Colors.black),
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
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
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
                SizedBox(
                  width: 25,
                ),
                SvgPicture.asset(
                  'assets/icons/facebook_icon.svg',
                  width: screenWidth(context, dividedBy: 30),
                  height: screenHeight(context, dividedBy: 30),
                ),
                SizedBox(
                  width: 25,
                ),
                SvgPicture.asset(
                  'assets/icons/apple-logo-svgrepo-com.svg',
                  width: screenWidth(context, dividedBy: 25),
                  height: screenHeight(context, dividedBy: 25),
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            _buildSignUpPrompt(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, IconData icon,
      {bool isPassword = false,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
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
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? SizedBox(
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

  Widget _buildSignUpPrompt() {
    return Center(
      child: RichText(
        text: const TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 15),
          children: [
            TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
