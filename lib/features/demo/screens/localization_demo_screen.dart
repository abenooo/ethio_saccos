import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/localization_provider.dart';
import '../../../generated/l10n/app_localizations.dart';

class LocalizationDemoScreen extends StatelessWidget {
  const LocalizationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('Localization Demo'),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Language Display
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Language',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        localizationProvider.currentLanguageName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Localized Strings Demo
                Text(
                  'Localized Strings Demo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Expanded(
                  child: ListView(
                    children: [
                      _buildDemoItem(context, 'App Title', AppLocalizations.of(context).appTitle),
                      _buildDemoItem(context, 'Welcome Back', AppLocalizations.of(context).welcomeBack),
                      _buildDemoItem(context, 'Sign In', AppLocalizations.of(context).signIn),
                      _buildDemoItem(context, 'Email Address', AppLocalizations.of(context).emailAddress),
                      _buildDemoItem(context, 'Password', AppLocalizations.of(context).password),
                      _buildDemoItem(context, 'My Accounts', AppLocalizations.of(context).myAccounts),
                      _buildDemoItem(context, 'Loan Calculator', AppLocalizations.of(context).loanCalculator),
                      _buildDemoItem(context, 'Statements', AppLocalizations.of(context).statements),
                      _buildDemoItem(context, 'Deposit', AppLocalizations.of(context).deposit),
                      _buildDemoItem(context, 'Withdraw', AppLocalizations.of(context).withdraw),
                      _buildDemoItem(context, 'Transfer', AppLocalizations.of(context).transfer),
                      _buildDemoItem(context, 'Settings', AppLocalizations.of(context).settings),
                      _buildDemoItem(context, 'Notifications', AppLocalizations.of(context).notifications),
                      _buildDemoItem(context, 'Security', AppLocalizations.of(context).security),
                      _buildDemoItem(context, 'Help Center', AppLocalizations.of(context).helpCenter),
                      _buildDemoItem(context, 'Logout', AppLocalizations.of(context).logout),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Language Switch Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => localizationProvider.changeLanguage('en'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: localizationProvider.locale.languageCode == 'en' 
                            ? cs.primary 
                            : cs.surfaceContainerHighest,
                          foregroundColor: localizationProvider.locale.languageCode == 'en' 
                            ? cs.onPrimary 
                            : cs.onSurface,
                        ),
                        child: const Text('English'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => localizationProvider.changeLanguage('am'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: localizationProvider.locale.languageCode == 'am' 
                            ? cs.primary 
                            : cs.surfaceContainerHighest,
                          foregroundColor: localizationProvider.locale.languageCode == 'am' 
                            ? cs.onPrimary 
                            : cs.onSurface,
                        ),
                        child: const Text('አማርኛ'),
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
  
  Widget _buildDemoItem(BuildContext context, String label, String value) {
    final cs = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
