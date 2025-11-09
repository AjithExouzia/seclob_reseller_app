import 'package:flutter/material.dart';
import 'package:seclob_app/core/utils/screensize.dart';
import '../../../../../../core/themes/app_theme.dart';
import '../../../auth/presentation/pages/sign_in_page.dart';
import '../widgets/onboarding_content.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _onboardingContents = [
    OnboardingContent(
      title: 'Welcome to',
      subtitle: 'Seclob',
      description:
          'Start growing your business with our platform — track sales, manage clients, and maximize profits.',
      svgPath: 'assets/images/Send money abroad.svg',
    ),
    OnboardingContent(
      title: 'Manage Your Partners',
      subtitle: 'Seamlessly',
      description:
          'Add, view, and collaborate with your team or resellers, all from a single dashboard.',
      svgPath: 'assets/images/Trust.svg',
    ),
    OnboardingContent(
      title: 'Analyze & Boost Your',
      subtitle: 'Earnings',
      description:
          'Get real-time reports, track performance, and maximize incentives with ease.',
      svgPath: 'assets/images/Receive Money.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth(context),
            height: screenHeight(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/Onboarding 12.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _onboardingContents.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _onboardingContents[index];
                    },
                  ),
                ),
                // Bottom section with transparent background
                _buildBottomSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingContents.length,
              (index) => Container(
                width: _currentPage == index ? 15 : 30, // Wider for active dot
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: _currentPage == index
                      ? BoxShape.rectangle
                      : BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  color: _currentPage == index
                      ? AppTheme.primaryColor
                      : Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight(context, dividedBy: 13)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == _onboardingContents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.surfaceColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
                elevation: 8,
              ),
              child: Text(
                _currentPage == _onboardingContents.length - 1
                    ? 'Sign in'
                    : 'Next',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
