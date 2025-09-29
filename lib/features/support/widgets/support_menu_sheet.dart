import 'package:flutter/material.dart';
import '../../savings/screens/savings_list_screen.dart';
import '../../loans/screens/loans_list_screen.dart';
import '../../../core/theme/theme.dart';

class SupportMenuSheet extends StatelessWidget {
  const SupportMenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<AppPalette>()!;

    return Container(
      decoration: BoxDecoration(
        color: palette.sectionBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, -6),
          )
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: palette.dotInactive,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quick Actions',
                    style: TextStyle(
                      color: palette.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: palette.iconPrimary.withOpacity(0.8)),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              const SizedBox(height: 8),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.82,
                ),
                children: [
                  _MenuItem(
                    icon: Icons.savings, 
                    label: 'Savings', 
                    onTap: () {
                      Navigator.of(context).pop(); // Close the bottom sheet first
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SavingsListScreen(),
                        ),
                      );
                    },
                  ),
                  _MenuItem(
                    icon: Icons.account_balance, 
                    label: 'Loans', 
                    onTap: () {
                      Navigator.of(context).pop(); // Close the bottom sheet first
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoansListScreen(),
                        ),
                      );
                    },
                  ),
                  _MenuItem(icon: Icons.swap_horiz, label: 'Transfer', onTap: () {}),
                  _MenuItem(icon: Icons.receipt_long, label: 'Statement', onTap: () {}),
                  _MenuItem(icon: Icons.payments, label: 'Deposit', onTap: () {}),
                  _MenuItem(icon: Icons.outbond, label: 'Withdraw', onTap: () {}),
                  _MenuItem(icon: Icons.support_agent, label: 'Help', onTap: () {}),
                  _MenuItem(icon: Icons.language, label: 'Language', onTap: () {}),
                ],
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                leading: CircleAvatar(
                  radius: 18,
                  backgroundColor: cs.primary.withOpacity(0.15),
                  child: Icon(Icons.chat_bubble_outline, color: cs.primary),
                ),
                title: Text('Chat with support', style: TextStyle(color: palette.textPrimary)),
                subtitle: Text('Get answers instantly', style: TextStyle(color: palette.textSecondary)),
                trailing: Icon(Icons.chevron_right, color: palette.iconPrimary.withOpacity(0.7)),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: palette.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: palette.cardBorder,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: palette.iconPrimary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: palette.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
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
