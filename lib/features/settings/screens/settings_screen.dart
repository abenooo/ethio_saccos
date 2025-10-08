import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../profile/screens/profile_screen.dart';
import '../../../core/theme/theme.dart';
import '../providers/biometric_provider.dart';
import '../../auth/services/auth_service.dart';
import '../../../core/utils/page_transitions.dart';

class SettingsScreen extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBackToHome;
  
  const SettingsScreen({super.key, this.showBackButton = true, this.onBackToHome});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Settings',
            showLanguage: false,
            onBackPressed: () {
              if (onBackToHome != null) {
                onBackToHome!();
              } else {
                Navigator.maybePop(context);
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
            // Account & Preferences Section
            _buildSectionHeader(context, 'Account & Preferences'),
            const SizedBox(height: 12),
            
            _buildSettingTile(
              context,
              icon: Icons.person_outline,
              title: 'My Profile',
              subtitle: 'View and edit your profile',
              onTap: () {
                context.pushFade(const ProfileScreen());
              },
            ),
            
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return _buildSettingTile(
                  context,
                  icon: themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  title: 'Theme',
                  subtitle: themeProvider.isDarkMode ? 'Dark Mode' : 'Light Mode',
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                    activeColor: colorScheme.primary,
                    activeTrackColor: colorScheme.primary.withValues(alpha:  0.3),
                    inactiveThumbColor: colorScheme.onSurface.withValues(alpha:  0.6),
                    inactiveTrackColor: colorScheme.onSurface.withValues(alpha:  0.2),
                  ),
                );
              },
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.language,
              title: 'Language',
              subtitle: 'English',
              onTap: () {
                _showLanguageDialog(context);
              },
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.text_fields,
              title: 'Font Size',
              subtitle: 'Medium',
              onTap: () {
                _showFontSizeDialog(context);
              },
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.notifications_outlined,
              title: 'Push Notifications',
              subtitle: 'Enabled',
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Handle notification toggle
                },
                activeColor: colorScheme.primary,
                activeTrackColor: colorScheme.primary.withValues(alpha:  0.3),
                inactiveThumbColor: colorScheme.onSurface.withValues(alpha:  0.6),
                inactiveTrackColor: colorScheme.onSurface.withValues(alpha:  0.2),
              ),
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.email_outlined,
              title: 'Email Notifications',
              subtitle: 'Weekly summary',
              onTap: () {},
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.vibration,
              title: 'Vibration',
              subtitle: 'Enabled',
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Handle vibration toggle
                },
                activeColor: colorScheme.primary,
                activeTrackColor: colorScheme.primary.withValues(alpha:  0.3),
                inactiveThumbColor: colorScheme.onSurface.withValues(alpha:  0.6),
                inactiveTrackColor: colorScheme.onSurface.withValues(alpha:  0.2),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Security & Support Section
            _buildSectionHeader(context, 'Security & Support'),
            const SizedBox(height: 12),
            
            _buildSettingTile(
              context,
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Last changed 3 months ago',
              onTap: () {},
            ),
            
            Consumer<BiometricProvider>(
              builder: (context, biometricProvider, child) {
                return _buildSettingTile(
                  context,
                  icon: Icons.fingerprint,
                  title: 'Biometric Authentication',
                  subtitle: biometricProvider.getSubtitleText(),
                  trailing: biometricProvider.isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colorScheme.primary,
                          ),
                        )
                      : Switch(
                          value: biometricProvider.isBiometricEnabled,
                          onChanged: biometricProvider.isBiometricAvailable
                              ? (value) => _handleBiometricToggle(context, biometricProvider)
                              : null,
                          activeColor: colorScheme.primary,
                          activeTrackColor: colorScheme.primary.withValues(alpha: 0.3),
                          inactiveThumbColor: colorScheme.onSurface.withValues(alpha: 0.6),
                          inactiveTrackColor: colorScheme.onSurface.withValues(alpha: 0.2),
                        ),
                );
              },
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.security,
              title: 'Two-Factor Authentication',
              subtitle: 'Disabled',
              onTap: () {},
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.help_outline,
              title: 'Help Center',
              subtitle: 'FAQs and support',
              onTap: () {},
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.chat_bubble_outline,
              title: 'Contact Us',
              subtitle: 'Get in touch',
              onTap: () {},
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.info_outline,
              title: 'About',
              subtitle: 'Version 1.0.0',
              onTap: () {},
            ),
            
            const SizedBox(height: 24),
            
            // Logout Button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.error.withValues(alpha:  0.1),
                  foregroundColor: colorScheme.error,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: colorScheme.error),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final textTheme = theme.textTheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(
          title,
          style: textTheme.headlineSmall?.copyWith(color: palette.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final palette = theme.extension<AppPalette>()!;
    final textTheme = theme.textTheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: palette.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha:  0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: colorScheme.primary,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(color: palette.textPrimary, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(color: palette.textSecondary),
        ),
        trailing: trailing ?? Icon(
          Icons.chevron_right,
          color: palette.iconPrimary.withOpacity(0.6),
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          title: Text(
            'Select Language',
            style: TextStyle(color: colorScheme.onSurface),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(context, 'English', true),
              _buildLanguageOption(context, 'Amharic', false),
              _buildLanguageOption(context, 'Oromo', false),
              _buildLanguageOption(context, 'Tigrinya', false),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageOption(BuildContext context, String language, bool isSelected) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      title: Text(
        language,
        style: TextStyle(color: colorScheme.onSurface),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: colorScheme.primary)
          : null,
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  void _showFontSizeDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          title: Text(
            'Font Size',
            style: TextStyle(color: colorScheme.onSurface),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFontSizeOption(context, 'Small', false),
              _buildFontSizeOption(context, 'Medium', true),
              _buildFontSizeOption(context, 'Large', false),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFontSizeOption(BuildContext context, String size, bool isSelected) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      title: Text(
        size,
        style: TextStyle(color: colorScheme.onSurface),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: colorScheme.primary)
          : null,
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  void _handleBiometricToggle(BuildContext context, BiometricProvider biometricProvider) async {
    if (!biometricProvider.isBiometricEnabled) {
      // Show dialog to enable biometric authentication
      _showBiometricSetupDialog(context, biometricProvider);
    } else {
      // Disable biometric authentication
      final success = await biometricProvider.toggleBiometric(null, null);
      if (success) {
        _showSnackBar(context, 'Biometric authentication disabled', false);
      }
    }
  }

  void _showBiometricSetupDialog(BuildContext context, BiometricProvider biometricProvider) {
    final colorScheme = Theme.of(context).colorScheme;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool isPasswordVisible = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: colorScheme.surface,
              title: Text(
                'Enable ${biometricProvider.biometricTypeName}',
                style: TextStyle(color: colorScheme.onSurface),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter your login credentials to enable biometric authentication.',
                    style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.7)),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                      Navigator.of(context).pop();
                      final success = await biometricProvider.toggleBiometric(
                        emailController.text.trim(),
                        passwordController.text,
                      );
                      if (success) {
                        _showSnackBar(context, 'Biometric authentication enabled successfully! You can now use biometrics to login.', true);
                      } else {
                        // Check if credentials are valid first
                        final isValidCredentials = AuthService.validateCredentials(
                          emailController.text.trim(),
                          passwordController.text,
                        );
                        
                        if (!isValidCredentials) {
                          _showSnackBar(context, 'Please enter valid email and password', false);
                        } else {
                          // Check if biometric is available
                          if (!biometricProvider.isBiometricAvailable) {
                            _showSnackBar(context, 'Biometric authentication not available on this device', false);
                          } else {
                            _showSnackBar(context, 'Biometric setup failed. Please make sure your device has fingerprint or face recognition enabled in device settings.', false);
                          }
                        }
                      }
                    } else {
                      _showSnackBar(context, 'Please enter both email and password', false);
                    }
                  },
                  child: Text(
                    'Enable',
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess 
            ? Theme.of(context).colorScheme.primary 
            : Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          title: Text(
            'Logout',
            style: TextStyle(color: colorScheme.onSurface),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: colorScheme.onSurface.withValues(alpha:  0.7)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle logout logic here
              },
              child: Text(
                'Logout',
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }
}
