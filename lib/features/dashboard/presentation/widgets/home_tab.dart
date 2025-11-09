import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seclob_app/core/providers/theme_provider.dart';
import 'package:seclob_app/features/notification/presentation/pages/notification_screen.dart';

import '../../../../core/themes/app_theme.dart';
import '../../../../core/utils/screensize.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentCarouselIndex = 0;

  final List<Map<String, dynamic>> carouselItems = [
    {
      'image': 'assets/images/banner_1.png',
    },
    {
      'image': 'assets/images/banner_2.png',
    },
    {
      'image': 'assets/images/banner_3.png',
    },
    {
      'image': 'assets/images/banner_1.png',
    },
    {
      'image': 'assets/images/banner_1.png',
    },
  ];

  final List<Map<String, dynamic>> services = [
    {
      'icon': 'assets/icons/e_card_logo.png',
      'title': 'E-card',
      'hasOffer': false,
    },
    {
      'icon': 'assets/icons/hr_insight_logo.png',
      'title': 'HR insight',
      'hasOffer': false,
    },
    {
      'icon': 'assets/icons/recharge_logo.png',
      'title': 'Recharge',
      'hasOffer': true,
      'offerText': 'Get 10% Extra',
    },
    {
      'icon': 'assets/icons/dth_logo.png',
      'title': 'DTH/Cable',
      'hasOffer': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(context, isDarkMode),
          const SizedBox(height: 20),
          _buildCarouselSlider(context),
          const SizedBox(height: 5),
          _buildServicesGrid(context, isDarkMode),
          const SizedBox(height: 24),
          _buildReferralSection(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SvgPicture.asset(
              'assets/images/home_header_image.svg',
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 3.2),
              fit: BoxFit.cover,
              color: isDarkMode ? AppTheme.darkSurfaceColor : null,
            ),
            Container(
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 3.2),
              child: Padding(
                padding:
                    EdgeInsets.only(left: screenWidth(context, dividedBy: 18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight(context, dividedBy: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          'Hey daniel!👋',
                          style: TextStyle(
                              color: isDarkMode
                                  ? AppTheme.darkTextPrimary.withOpacity(0.8)
                                  : Colors.black.withOpacity(0.8),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: screenWidth(context, dividedBy: 2.2),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ));
                          },
                          child: SvgPicture.asset(
                            'assets/icons/Notification.svg',
                            width: screenWidth(context, dividedBy: 34),
                            height: screenHeight(context, dividedBy: 34),
                            color: isDarkMode ? AppTheme.darkTextPrimary : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 32),
                    ),
                    Text('Available balance',
                        style: TextStyle(
                            color: isDarkMode
                                ? AppTheme.darkTextPrimary.withOpacity(0.6)
                                : Colors.black.withOpacity(0.6),
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 5),
                    Text(
                      '\u20B925,000.00',
                      style: TextStyle(
                          color: isDarkMode
                              ? AppTheme.darkTextPrimary.withOpacity(0.8)
                              : Colors.black.withOpacity(0.8),
                          fontSize: 39,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: screenWidth(context, dividedBy: 4.5),
                      height: screenHeight(context, dividedBy: 21),
                      decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 25,
                          ),
                          Text(
                            'Add',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCarouselSlider(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: carouselItems.map((item) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/image 68.png'),
                      fit: BoxFit.cover)),
            );
          }).toList(),
          options: CarouselOptions(
            height: screenHeight(context, dividedBy: 6.5),
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselItems.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentCarouselIndex == entry.key
                    ? AppTheme.primaryColor
                    : Colors.grey.shade300,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              'Services',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: isDarkMode
                      ? AppTheme.darkTextPrimary.withOpacity(0.7)
                      : Colors.black.withOpacity(0.7)),
            ),
          ),
          const SizedBox(height: 3),
          GridView.builder(
            padding: const EdgeInsets.only(top: 12),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.1,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return _buildServiceItem(context, services[index], isDarkMode);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(
      BuildContext context, Map<String, dynamic> service, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkSurfaceColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Image.asset(
                  service['icon'],
                  width: screenWidth(context, dividedBy: 10),
                  height: screenHeight(context, dividedBy: 10),
                  fit: BoxFit.contain,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      service['title'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode
                            ? AppTheme.darkTextPrimary
                            : AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (service['hasOffer'] == true)
            Positioned(
              top: 0,
              right: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(11)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accentColor.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Get 10% Extra',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReferralSection(BuildContext context) {
    return Center(
      child: Container(
        width: screenWidth(context, dividedBy: 1.1),
        height: screenHeight(context, dividedBy: 5.5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
                image: AssetImage('assets/images/refer_a_friend_image.png'))),
      ),
    );
  }
}
