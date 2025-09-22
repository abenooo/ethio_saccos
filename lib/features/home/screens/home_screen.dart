import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/widgets/app_drawer.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/card_carousel.dart';

class HomeScreen extends StatelessWidget {
  final bool showBottomNav;
  
  const HomeScreen({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final cs = Theme.of(context).colorScheme;
    final gradients = Theme.of(context).extension<AppGradients>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
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
            _AccountMenuSection(isDark: isDark),
        ],
      ),
      bottomNavigationBar: showBottomNav ? ChangeNotifierProvider(
        create: (_) => AppNavigationController(),
        child: Consumer<AppNavigationController>(
          builder: (context, controller, _) {
            return AppBottomNavBar(
              items: controller.getNavigationItems(),
            );
          },
        ),
      ) : null,
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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

class _AccountMenuSection extends StatelessWidget {
  final bool isDark;

  const _AccountMenuSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          
          // Account Service Cards - All 6 cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              _buildQuickAccessCard(
                context,
                icon: Icons.account_balance_wallet,
                title: 'Accounts',
                subtitle: 'View all accounts',
                color: Colors.blue,
              ),
              _buildQuickAccessCard(
                context,
                icon: Icons.account_balance,
                title: 'Balance',
                subtitle: 'Check balance',
                color: Colors.green,
              ),
              _buildQuickAccessCard(
                context,
                icon: Icons.receipt_long,
                title: 'Statement',
                subtitle: 'View statements',
                color: Colors.purple,
              ),
              _buildQuickAccessCard(
                context,
                icon: Icons.add_circle,
                title: 'Deposit',
                subtitle: 'Add money',
                color: Colors.orange,
              ),
              _buildQuickAccessCard(
                context,
                icon: Icons.remove_circle,
                title: 'Withdraw',
                subtitle: 'Take money',
                color: Colors.red,
              ),
              _buildQuickAccessCard(
                context,
                icon: Icons.swap_horiz,
                title: 'Transfer',
                subtitle: 'Send money',
                color: Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return GestureDetector(
      onTap: () {
        // TODO: Add functionality for each card later
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onBackground.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}



