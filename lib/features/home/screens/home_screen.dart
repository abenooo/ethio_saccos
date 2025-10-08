import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/app_drawer.dart';
import '../../../core/widgets/card_carousel.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/services/navigation_service.dart';
import '../../loans/screens/loan_calculator_screen.dart';
import 'transaction_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool showBottomNav;
  
  const HomeScreen({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final gradients = Theme.of(context).extension<AppGradients>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final palette = Theme.of(context).extension<AppPalette>()!;
    
    return Scaffold(
      backgroundColor: cs.surface,
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          // Sticky App Bar with Green Gradient
          SliverAppBar(
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: cs.secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.menu_rounded,
                          color: cs.secondary,
                          size: 24,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: cs.secondary.withValues(alpha: 0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Abenezer Kifle',
                            style: TextStyle(
                              color: cs.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: cs.secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        color: cs.secondary,
                        size: 24,
                      ),
                      onPressed: () {
                        context.read<ThemeProvider>().toggleTheme();
                      },
                    ),
                  ),
                ],
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: gradients.headerGradient,
              ),
            ),
          ),
          
          // Scrollable Content
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Golden yellow background with curved bottom - Extended height
                Container(
                  height: 350, // Increased from 280 to extend into quick actions area
                  decoration: BoxDecoration(
                    gradient: gradients.headerGradient,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // Card Carousel Section (replacing balance card)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: CardCarousel(
                          isDark: isDark,
                          cardGradient: gradients.cardGradient,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _ModernQuickActions(isDark: isDark),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Account Menu Section
          SliverToBoxAdapter(
            child: _AccountMenuSection(isDark: isDark),
          ),
        ],
      ),
      // Bottom navigation is handled by MainNavigationScreen when needed
    );
  }
}

// Modern Balance Card Widget
class _ModernBalanceCard extends StatelessWidget {
  final bool isDark;

  const _ModernBalanceCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.visibility_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'KSh 245,680',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _BalanceIndicator(
                  icon: Icons.south_west_rounded,
                  label: 'Income',
                  amount: 'KSh 85,450',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _BalanceIndicator(
                  icon: Icons.north_east_rounded,
                  label: 'Expenses',
                  amount: 'KSh 23,120',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BalanceIndicator extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;

  const _BalanceIndicator({
    required this.icon,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 14,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Modern Quick Actions Widget
class _ModernQuickActions extends StatelessWidget {
  final bool isDark;

  const _ModernQuickActions({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Always white for the new design
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 25,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.black, // Always black text on white background
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _QuickActionButton(
                icon: Icons.savings_rounded,
                label: 'Saving\nDeposit',
                backgroundColor: cs.primary, // Use theme primary color
                onTap: () {
                  NavigationService.navigateToSavings(context);
                },
              ),
              _QuickActionButton(
                icon: Icons.account_balance_rounded,
                label: 'Loan\nApply',
                backgroundColor: cs.primary, // Use theme primary color
                onTap: () {
                  NavigationService.navigateToLoans(context);
                },
              ),
              _QuickActionButton(
                icon: Icons.payment_rounded,
                label: 'Pay\nBills',
                backgroundColor: cs.primary, // Use theme primary color
                onTap: () {
                  // TODO: Navigate to payment screen
                },
              ),
              _QuickActionButton(
                icon: Icons.history_rounded,
                label: 'View\nHistory',
                backgroundColor: cs.primary, // Use theme primary color
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TransactionDetailsScreen(
                        title: 'Transaction History',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundColor,
                  backgroundColor.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              Text(
                label.split('\n')[0], // First part (Saving, Loan, Pay, View)
                style: TextStyle(
                  color: Colors.black, // Always black text on white background
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                label.split('\n')[1], // Second part (Deposit, Apply, Bills, History)
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.6), // Faded black text
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
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
          
          // Account Service Cards - Clean banking style
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.0,
            children: [
            _buildQuickAccessCard(
              context,
              icon: Icons.account_balance_wallet_outlined,
              title: 'My Accounts',
              subtitle: '',
              accentColor: Theme.of(context).colorScheme.secondary,
            ),
            _buildQuickAccessCard(
              context,
              icon: Icons.calculate_outlined,
              title: 'Loan Calculator',
              subtitle: '',
              accentColor: Theme.of(context).colorScheme.secondary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoanCalculatorScreen(),
                  ),
                );
              },
            ),
            _buildQuickAccessCard(
              context,
              icon: Icons.receipt_long_outlined,
              title: 'Statements',
              subtitle: '',
              accentColor: Theme.of(context).colorScheme.secondary,
            ),
            _buildQuickAccessCard(
              context,
              icon: Icons.add_circle_outline,
              title: 'Deposit',
              subtitle: '',
              accentColor: Theme.of(context).colorScheme.secondary,
            ),
            _buildQuickAccessCard(
              context,
              icon: Icons.remove_circle_outline,
              title: 'Withdraw',
              subtitle: '',
              accentColor: Theme.of(context).colorScheme.secondary,
            ),
            _buildQuickAccessCard(
              context,
              icon: Icons.swap_horiz_outlined,
              title: 'Transfer',
              subtitle: '',
              accentColor: Theme.of(context).colorScheme.secondary,
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
    required Color accentColor,
    VoidCallback? onTap,
  }) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () {
          // TODO: Add functionality for each card later
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              // Isometric 3D shadow effect
              BoxShadow(
                color: isDark 
                  ? Colors.black.withValues(alpha: 0.4)
                  : const Color(0xFF000000).withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(4, 8), // Isometric offset
                spreadRadius: 0,
              ),
              // Secondary shadow for depth
              BoxShadow(
                color: isDark 
                  ? Colors.black.withValues(alpha: 0.2)
                  : const Color(0xFF000000).withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(2, 4),
                spreadRadius: 0,
              ),
              // Subtle highlight on top
              BoxShadow(
                color: Colors.white.withValues(alpha: isDark ? 0.05 : 0.8),
                blurRadius: 1,
                offset: const Offset(0, -1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon with brand color gradient background
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary, // Brand yellow
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.8), // Darker yellow
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.secondary, // Dark chocolate
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              // Title with compact layout
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: palette.textPrimary,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}