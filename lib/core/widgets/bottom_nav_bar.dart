import 'package:flutter/material.dart';

class BottomNavItem {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const BottomNavItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });
}

class AppBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final Color? backgroundColor;
  final double elevation;
  final EdgeInsets padding;

  const AppBottomNavBar({
    super.key,
    required this.items,
    this.backgroundColor,
    this.elevation = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  });

  Widget _buildNavItem(BuildContext context, BottomNavItem item) {
    final theme = Theme.of(context);
    final color = item.isSelected 
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface.withValues(alpha: 0.4);

    return InkWell(
      onTap: item.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon, 
            color: color, 
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: item.isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface,
        boxShadow: [
          if (elevation > 0)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: elevation,
              offset: const Offset(0, -5),
            ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items
                .map((item) => _buildNavItem(context, item))
                .toList(),
          ),
        ),
      ),
    );
  }
}

// Navigation controller to handle state
class AppNavigationController extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  List<BottomNavItem> getNavigationItems() {
    return [
      BottomNavItem(
        icon: Icons.home_filled,
        label: 'Home',
        isSelected: _selectedIndex == 0,
        onTap: () => setIndex(0),
      ),
      BottomNavItem(
        icon: Icons.account_balance,
        label: 'Loans',
        isSelected: _selectedIndex == 1,
        onTap: () => setIndex(1),
      ),
      BottomNavItem(
        icon: Icons.savings,
        label: 'Savings',
        isSelected: _selectedIndex == 2,
        onTap: () => setIndex(2),
      ),
      BottomNavItem(
        icon: Icons.settings,
        label: 'Settings',
        isSelected: _selectedIndex == 3,
        onTap: () => setIndex(3),
      ),
    ];
  }
}
