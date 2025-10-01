import 'package:flutter/material.dart';
import '../services/navigation_service.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/home/screens/transaction_details_screen.dart';
import '../../features/auth/services/auth_service.dart';
import '../../main.dart';
import '../theme/theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _buildGroupHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final textTheme = theme.textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: textTheme.bodySmall?.copyWith(
          color: palette.textSecondary,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, 
    IconData icon, 
    String title, 
    {VoidCallback? onTap}
  ) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final textTheme = theme.textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: textTheme.bodyLarge?.copyWith(
            color: palette.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: palette.iconPrimary.withValues(alpha: 0.6),
          size: 18,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        hoverColor: theme.colorScheme.primary.withValues(alpha: 0.05),
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E3A8A), // Primary Blue
            const Color(0xFF0F766E), // Secondary Teal
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Profile Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),
              
              // User Name
              Text(
                'Abenezer Kifle',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              
              // Member ID
              Text(
                'Member ID: SAC001234',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(color: theme.colorScheme.surface),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header Section
            _buildHeader(context),
            
            // Member Section
            _buildGroupHeader(context, 'Member'),
            _buildMenuItem(
              context,
              Icons.savings,
              'Savings Accounts',
              onTap: () {
                NavigationService.popAndCloseDrawer(context);
                NavigationService.navigateToSavings(context);
              },
            ),
            _buildMenuItem(
              context,
              Icons.account_balance,
              'Loans',
              onTap: () {
                NavigationService.popAndCloseDrawer(context);
                NavigationService.navigateToLoans(context);
              },
            ),
            _buildMenuItem(
              context,
              Icons.pie_chart,
              'Shares',
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const TransactionDetailsScreen(title: 'Share Account', isShare: true),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              Icons.swap_horiz,
              'Transfers',
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const TransactionDetailsScreen(title: 'Transfers'),
                  ),
                );
              },
            ),
            
            // Settings Section
            _buildGroupHeader(context, 'Settings'),
            _buildMenuItem(
              context,
              Icons.notifications,
              'Notifications',
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                );
              },
            ),
            _buildMenuItem(context, Icons.lock, 'Privacy & Security'),
            _buildMenuItem(context, Icons.language, 'Language'),
            
            // Support Section
            _buildGroupHeader(context, 'Support'),
            _buildMenuItem(context, Icons.help, 'Help Center'),
            _buildMenuItem(context, Icons.support_agent, 'Contact Support'),
            _buildMenuItem(context, Icons.info, 'About SACCO'),
            
            // Divider
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Divider(
                color: Theme.of(context).extension<AppPalette>()!.cardBorder,
                thickness: 1,
              ),
            ),
            
            // Logout Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.error.withValues(alpha: 0.05),
              ),
              child: _buildMenuItem(
                context,
                Icons.logout,
                'Logout',
                onTap: () {
                  Navigator.pop(context);
                  AuthService.logout();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const AppInitializer()),
                    (route) => false,
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
