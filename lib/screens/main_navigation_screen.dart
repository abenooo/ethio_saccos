import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../core/theme/theme.dart';
import '../core/providers/card_data_provider.dart';
import '../features/home/screens/home_screen.dart';
import '../features/savings/screens/savings_list_screen.dart';
import '../features/loans/screens/loans_list_screen.dart';
import '../features/home/screens/transaction_details_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/support/widgets/floating_chat_button.dart';
import '../core/providers/theme_provider.dart';
import '../generated/l10n/app_localizations.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  final String? mainAccountBalance;
  final dynamic loanCardData; // Add loan card data parameter
  
  const MainNavigationScreen({
    super.key, 
    this.initialIndex = 2, // Default to Home screen
    this.mainAccountBalance,
    this.loanCardData,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex;

  // Use centralized card data provider for better performance
  late final CardDataProvider _cardDataProvider = CardDataProvider();

   late final List<Widget> _screens = [
      LoansListScreen(
        onBackToHome: () => _onItemTapped(2),
        loanCardData: widget.loanCardData ?? _cardDataProvider.getLoanCardData(),
      ),
      SavingsListScreen(
        onBackToHome: () => _onItemTapped(2),
        mainAccountBalance: widget.mainAccountBalance ?? _cardDataProvider.getMainAccountBalance(),
      ),
      const HomeScreen(showBottomNav: false),
      TransactionDetailsScreen(title: 'Transaction History', onBackToHome: () => _onItemTapped(2)),
      SettingsScreen(showBackButton: false, onBackToHome: () => _onItemTapped(2)),
    ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          const FloatingChatButton(),
        ],
      ),
      bottomNavigationBar: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final palette = Theme.of(context).extension<AppPalette>()!;
          // Align nav bar with SACCO theme neutrals
          final navBarColor = palette.sectionBg;
          final iconColor = palette.iconPrimary;
              
          return CurvedNavigationBar(
            index: _selectedIndex,
            height: 60.0,
            items: <Widget>[
              Icon(
                Icons.account_balance,
                size: 30,
                color: iconColor,
              ),
              Icon(
                Icons.savings,
                size: 30,
                color: iconColor,
              ),
              Icon(
                Icons.home_filled,
                size: 32, // Slightly larger for emphasis
                color: iconColor,
              ),
              Icon(
                Icons.history,
                size: 30,
                color: iconColor,
              ),
              Icon(
                Icons.settings,
                size: 30,
                color: iconColor,
              ),
            ],
            color: navBarColor,
            buttonBackgroundColor: navBarColor,
            backgroundColor: colorScheme.background,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) => _onItemTapped(index),
            letIndexChange: (index) => true,
          );
        },
      ),
    );
  }

}

// Theme Switcher Screen
class ThemeSwitcherScreen extends StatelessWidget {
  const ThemeSwitcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Theme',
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Theme illustration
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    size: 100,
                    color: colorScheme.primary,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                Text(
                  themeProvider.isDarkMode ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onBackground,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                Text(
                  themeProvider.isDarkMode 
                      ? 'Enjoy a comfortable viewing experience in low light'
                      : 'Bright and clear interface for daytime use',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onBackground.withValues(alpha: 0.7),
                  ),
                ),
                
                const SizedBox(height: 60),
                
                // Theme toggle button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        themeProvider.toggleTheme();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                            color: colorScheme.onPrimary,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Switch to ${themeProvider.isDarkMode ? 'Light' : 'Dark'} Mode',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Additional theme options
                Row(
                  children: [
                    Expanded(
                      child: _buildThemeOption(
                        context,
                        'Auto',
                        Icons.brightness_auto,
                        false,
                        () {
                          // TODO: Implement auto theme based on system
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildThemeOption(
                        context,
                        'System',
                        Icons.settings_system_daydream,
                        false,
                        () {
                          // TODO: Implement system theme
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primary.withValues(alpha: 0.1) : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: isSelected 
            ? Border.all(color: colorScheme.primary, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: colorScheme.onBackground.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.7),
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// SACCO-specific screens
class LoansScreen extends StatelessWidget {
  const LoansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).loans,
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance,
              size: 80,
              color: colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).loanServices,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).applyLoans,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onBackground.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).savings,
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.savings,
              size: 80,
              color: colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).savingsAccount,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).manageSavings,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onBackground.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
