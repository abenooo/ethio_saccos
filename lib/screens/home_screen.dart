import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../providers/theme_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/card_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final cs = Theme.of(context).colorScheme;
    final gradients = Theme.of(context).extension<AppGradients>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ChangeNotifierProvider(
      create: (_) => AppNavigationController(),
      child: Scaffold(
        backgroundColor: cs.background,
        drawer: const AppDrawer(),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(gradient: gradients.headerGradient),
              padding: EdgeInsets.fromLTRB(16, top + 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(),
                  const SizedBox(height: 24),
                  CardCarousel(
                    isDark: isDark,
                    cardGradient: gradients.cardGradient,
                  ),
                  const SizedBox(height: 32),
                  _QuickActions(isDark: isDark),
                ],
              ),
            ),
            _TransactionSection(isDark: isDark),
          ],
        ),
        bottomNavigationBar: Consumer<AppNavigationController>(
          builder: (context, controller, _) {
            return AppBottomNavBar(
              items: controller.getNavigationItems(),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.onBackground,  // This will ensure visibility in both modes
            size: 28,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 4),
              const Text(
                'Abenezer kifle ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.white.withOpacity(0.1)
                : const Color(0xFFEDF3FF), // Light blue background
            shape: BoxShape.circle,
            border: isDark 
                ? null 
                : Border.all(color: Colors.blue.withOpacity(0.2)),
          ),
          child: IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.white : Colors.blue[700],
              size: 24,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ),
      ],
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final Gradient cardGradient;
  final bool isDark;

  const _BalanceCard({
    required this.cardGradient,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.credit_card_outlined,
                  color: isDark ? Colors.white70 : Colors.white),
              const Spacer(),
              Icon(Icons.contactless,
                  color: isDark ? Colors.white70 : Colors.white),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '4562  1122  4595  7852',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AR Jonson',
                      style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.white)),
                  const SizedBox(height: 8),
                  Text(
                    'Expiry Date\n24/2000',
                    style: TextStyle(
                        color: isDark ? Colors.white60 : Colors.white70,
                        fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Replace Mastercard image with text
                  Text(
                    'Mastercard',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'CVV\n6986',
                    style: TextStyle(
                        color: isDark ? Colors.white60 : Colors.white70,
                        fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final bool isDark;

  const _QuickActions({required this.isDark});

  Widget _item(IconData icon, String label) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.white.withOpacity(0.1)
                : const Color(0xFFEDF3FF), // Light blue background
            shape: BoxShape.circle,
            border: isDark 
                ? null 
                : Border.all(color: Colors.blue.withOpacity(0.2)),
          ),
          child: Icon(
            icon,
            color: isDark ? Colors.white : Colors.blue[700],
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _item(Icons.north_east, 'Sent'),
        _item(Icons.south_west, 'Receive'),
        _item(Icons.account_balance, 'Loan'),
        _item(Icons.cloud_upload, 'Topup'),
      ],
    );
  }
}

class _TransactionSection extends StatelessWidget {
  final bool isDark;

  const _TransactionSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: isDark ? Colors.blue : Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



