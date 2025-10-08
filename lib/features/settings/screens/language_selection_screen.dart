import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/localization_provider.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../generated/l10n/app_localizations.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: cs.surface,
      appBar: const CustomAppBar(
        title: 'Language / ቋንቋ',
        showBackButton: true,
      ),
      body: Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: localizationProvider.availableLanguages.length,
            itemBuilder: (context, index) {
              final language = localizationProvider.availableLanguages[index];
              final isSelected = localizationProvider.locale.languageCode == language['code'];
              
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected 
                      ? cs.primary 
                      : cs.outline.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cs.shadow.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isSelected 
                        ? cs.primary.withValues(alpha: 0.1)
                        : cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.language,
                      color: isSelected ? cs.primary : cs.onSurfaceVariant,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    language['name']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? cs.primary : cs.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    language['nativeName']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  trailing: isSelected
                    ? Icon(
                        Icons.check_circle,
                        color: cs.primary,
                        size: 24,
                      )
                    : null,
                  onTap: () async {
                    if (!isSelected) {
                      await localizationProvider.changeLanguage(language['code']!);
                      
                      // Show confirmation snackbar
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              language['code'] == 'am' 
                                ? 'ቋንቋ ወደ አማርኛ ተቀይሯል'
                                : 'Language changed to English',
                            ),
                            backgroundColor: cs.primary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
