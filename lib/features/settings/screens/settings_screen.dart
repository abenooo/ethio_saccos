import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/theme_provider.dart';
import '../../profile/screens/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  final bool showBackButton;
  
  const SettingsScreen({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: showBackButton ? IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
          onPressed: () => Navigator.of(context).pop(),
        ) : null,
        automaticallyImplyLeading: showBackButton,
        title: Text(
          'Settings',
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _buildSectionHeader(context, 'Profile'),
            const SizedBox(height: 12),
            
            _buildSettingTile(
              context,
              icon: Icons.person_outline,
              title: 'My Profile',
              subtitle: 'View and edit your profile',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // Appearance Section
            _buildSectionHeader(context, 'Appearance'),
            const SizedBox(height: 12),
            
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
            
            const SizedBox(height: 32),
            
            // Notifications Section
            _buildSectionHeader(context, 'Notifications'),
            const SizedBox(height: 12),
            
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
            
            // Security Section
            _buildSectionHeader(context, 'Security'),
            const SizedBox(height: 12),
            
            _buildSettingTile(
              context,
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Last changed 3 months ago',
              onTap: () {},
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.fingerprint,
              title: 'Biometric Authentication',
              subtitle: 'Face ID enabled',
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Handle biometric toggle
                },
                activeColor: colorScheme.primary,
                activeTrackColor: colorScheme.primary.withValues(alpha:  0.3),
                inactiveThumbColor: colorScheme.onSurface.withValues(alpha:  0.6),
                inactiveTrackColor: colorScheme.onSurface.withValues(alpha:  0.2),
              ),
            ),
            
            _buildSettingTile(
              context,
              icon: Icons.security,
              title: 'Two-Factor Authentication',
              subtitle: 'Disabled',
              onTap: () {},
            ),
            
            const SizedBox(height: 32),
            
            // Support Section
            _buildSectionHeader(context, 'Support'),
            const SizedBox(height: 12),
            
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
            
            const SizedBox(height: 32),
            
            // Logout Button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withValues(alpha:  0.1),
                  foregroundColor: Colors.red,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
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
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onBackground.withValues(alpha:  0.03),
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSurface.withValues(alpha:  0.7),
          ),
        ),
        trailing: trailing ?? Icon(
          Icons.chevron_right,
          color: colorScheme.onSurface.withValues(alpha:  0.4),
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
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
