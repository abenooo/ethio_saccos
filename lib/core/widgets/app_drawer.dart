import 'package:flutter/material.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/home/screens/transaction_details_screen.dart';
import '../../features/auth/services/auth_service.dart';
import '../../main.dart';
import '../../features/savings/screens/savings_list_screen.dart';
import '../../features/loans/screens/loans_list_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _buildGroupHeader(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 12,
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
            color: theme.colorScheme.primary.withOpacity(0.1),
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
          style: TextStyle(
            color: theme.colorScheme.onBackground,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: theme.colorScheme.onBackground.withOpacity(0.4),
          size: 18,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        hoverColor: theme.colorScheme.primary.withOpacity(0.05),
        splashColor: theme.colorScheme.primary.withOpacity(0.1),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.onPrimary.withOpacity(0.15),
              border: Border.all(
                color: theme.colorScheme.onPrimary.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.person,
              color: theme.colorScheme.onPrimary,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Abenezer Kifle',
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+251 910 979060 678',
              style: TextStyle(
                color: theme.colorScheme.onPrimary.withOpacity(0.9),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Drawer(
      backgroundColor: theme.colorScheme.background,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.background,
              theme.colorScheme.surface.withOpacity(0.3),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(context),
            
            // Member Section
            _buildGroupHeader(context, 'Member'),
            _buildMenuItem(
              context,
              Icons.savings,
              'Savings Accounts',
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SavingsListScreen()),
                );
              },
            ),
            _buildMenuItem(
              context,
              Icons.account_balance,
              'Loans',
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoansListScreen()),
                );
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
                color: theme.colorScheme.outline.withOpacity(0.3),
                thickness: 1,
              ),
            ),
            
            // Logout Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.red.withOpacity(0.05),
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
