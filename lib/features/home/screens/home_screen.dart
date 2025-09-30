import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/card_carousel.dart';
import '../../../core/widgets/app_drawer.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/services/navigation_service.dart';
import '../../savings/screens/savings_list_screen.dart';
import '../../loans/screens/loans_list_screen.dart';
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
          // Sticky App Bar
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
                      color: palette.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF1E3A8A).withOpacity(0.3), // Primary blue border
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1E3A8A).withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Color(0xFF1E3A8A), // Primary blue icon
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
                              color: palette.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Abenezer Kifle',
                            style: TextStyle(
                              color: palette.textPrimary,
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
                      color: palette.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFD97706).withOpacity(0.3), // Accent gold border
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD97706).withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        color: const Color(0xFFD97706), // Accent gold icon
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
                color: palette.sectionBg,
              ),
            ),
          ),
          
          // Scrollable Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: palette.sectionBg,
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  CardCarousel(
                    isDark: isDark,
                    cardGradient: gradients.cardGradient,
                  ),
                  const SizedBox(height: 32),
                  // Quick Actions Label
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Quick Actions',
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  _QuickActions(isDark: isDark),
                ],
              ),
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



class _QuickActions extends StatelessWidget {
  final bool isDark;

  const _QuickActions({required this.isDark});

  // Use centralized navigation service for better performance
  static final NavigationService _navigationService = NavigationService();

  Widget _item(BuildContext context, IconData icon, String label, String subtitle, VoidCallback? onTap, Color accentColor) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: palette.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: accentColor.withOpacity(0.4),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: accentColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: palette.textPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: palette.textSecondary,
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Single consistent brand color for all quick actions
    const brandColor = Color(0xFF1E3A8A); // Primary blue for all
    
    return Row(
      children: [
        _item(context, Icons.savings_rounded, 'Savings', 'Deposit', () {
          NavigationService.navigateToSavings(context);
        }, brandColor),
        _item(context, Icons.account_balance_rounded, 'Loan', 'Apply', () {
          NavigationService.navigateToLoans(context);
        }, brandColor),
        _item(context, Icons.payment_rounded, 'Pay', 'Bills', () {
          // TODO: Navigate to payment screen
        }, brandColor),
        _item(context, Icons.history_rounded, 'View', 'History', () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TransactionDetailsScreen(
                title: 'Transaction History',
              ),
            ),
          );
        }, brandColor),
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
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.2,
            children: [
            _buildQuickAccessCard(
              context,
              icon: Icons.account_balance_wallet,
              title: 'Accounts',
              subtitle: 'View all accounts',
              accentColor: const Color(0xFF1E3A8A), // Primary blue
            ),
            _buildQuickAccessCard(
              context,
              icon: Icons.calculate,
              title: 'Loan Calculator',
              subtitle: 'Calculate loans',
              accentColor: const Color(0xFF1E3A8A), // Primary blue
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
              icon: Icons.receipt_long,
              title: 'Statement',
              subtitle: 'View statements',
              accentColor: const Color(0xFF1E3A8A), // Primary blue
            ),
            _buildQuickAccessCard(
              context,
              icon: Icons.add_circle,
              title: 'Deposit',
              subtitle: 'Add money',
              accentColor: const Color(0xFF1E3A8A), // Primary blue
            ),
            _buildQuickAccessCard(
              context,
              icon: Icons.remove_circle,
              title: 'Withdraw',
              subtitle: 'Take money',
              accentColor: const Color(0xFF1E3A8A), // Primary blue
            ),
            _buildQuickAccessCard(
              context,
              icon: Icons.swap_horiz,
              title: 'Transfer',
              subtitle: 'Send money',
              accentColor: const Color(0xFF1E3A8A), // Primary blue
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
    
    return GestureDetector(
      onTap: onTap ?? () {
        // TODO: Add functionality for each card later
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark 
              ? [
                  const Color(0xFF1E293B),
                  const Color(0xFF334155),
                ]
              : [
                  Colors.white,
                  const Color(0xFFF8FAFC),
                ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: accentColor.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accentColor.withOpacity(0.1),
                    accentColor.withOpacity(0.2),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: accentColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                color: accentColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: palette.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 9,
                      color: palette.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



