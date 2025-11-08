import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
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
      subtitle: 'Seclob', // Changed from Seabob to Seclob
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
      title: 'Analyze & Boost',
      subtitle: 'Your Earnings',
      description:
          'Get real-time reports, track performance, and maximize incentives with ease.',
      svgPath: 'assets/images/Receive Money.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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

            // Indicator and navigation
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Page indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingContents.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? AppTheme.primaryColor
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Next/Get Started button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == _onboardingContents.length - 1) {
                  // Last page - navigate to sign in
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                } else {
                  // Next page
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              child: Text(
                _currentPage == _onboardingContents.length - 1
                    ? 'Sign in'
                    : 'Next',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
