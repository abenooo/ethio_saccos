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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
          fontSize: 14,
          fontWeight: FontWeight.w600,
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
    return ListTile(
      leading: Icon(
        icon,
        color: theme.colorScheme.onBackground,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.onBackground,
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 0,
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return DrawerHeader(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.onPrimary.withOpacity(0.2),
            ),
            child: Icon(
              Icons.person,
              color: theme.colorScheme.onPrimary,
              size: 40,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Abenezer Kifle',
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '+251 912 345 678',
            style: TextStyle(
              color: theme.colorScheme.onPrimary.withOpacity(0.8),
              fontSize: 14,
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(context),
          
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
          
          _buildGroupHeader(context, 'Support'),
          _buildMenuItem(context, Icons.help, 'Help Center'),
          _buildMenuItem(context, Icons.support_agent, 'Contact Support'),
          _buildMenuItem(context, Icons.info, 'About SACCO'),
          
          const Divider(),
          _buildMenuItem(
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
        ],
      ),
    );
  }
}
