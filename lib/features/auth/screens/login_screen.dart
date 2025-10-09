import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'register_screen.dart';
import 'forgot_screen.dart';
import '../services/auth_service.dart';
import '../../settings/providers/biometric_provider.dart';
import '../../../screens/main_navigation_screen.dart';
import '../../../core/utils/page_transitions.dart';
import '../../../generated/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize biometric provider when login screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final biometricProvider = Provider.of<BiometricProvider>(context, listen: false);
      biometricProvider.initialize();
    });
  }

  Future<void> _handleBiometricLogin(BiometricProvider biometricProvider) async {
    try {
      print('Biometric login started...');
      print('Biometric enabled: ${biometricProvider.isBiometricEnabled}');
      print('Biometric available: ${biometricProvider.isBiometricAvailable}');
      
      final credentials = await biometricProvider.performBiometricLogin();
      print('Biometric credentials result: $credentials');
      
      if (credentials != null) {
        print('Attempting login with biometric credentials...');
        // Login with stored biometric credentials
        final success = await AuthService.login(
          email: credentials['email'],
          password: credentials['password'],
        );
        
        if (success) {
          print('Biometric login successful!');
          if (!mounted) return;
          context.pushReplacementFade(const MainNavigationScreen());
        } else {
          print('Login failed with stored credentials');
          _showSnackBar('Login failed with stored credentials');
        }
      } else {
        print('Biometric authentication returned null');
        _showSnackBar('Biometric authentication failed');
      }
    } catch (e) {
      print('Biometric authentication error: $e');
      _showSnackBar('Biometric authentication error: $e');
    }
  }

  Future<void> _handleRegularLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please enter both email and password');
      return;
    }
    
    final success = await AuthService.login(email: email, password: password);
    
    if (success) {
      if (!mounted) return;
      context.pushReplacementFade(const MainNavigationScreen());
    } else {
      _showSnackBar('Invalid email or password');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: cs.onBackground,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                         MediaQuery.of(context).padding.top - 
                         MediaQuery.of(context).padding.bottom - 
                         kToolbarHeight - 40, // Account for padding
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: SvgPicture.asset(
                  'asset/app_logo.svg', 
                  width: 56, 
                  height: 56,
                  colorFilter: ColorFilter.mode(
                    cs.secondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context).signIn, 
              style: TextStyle(color: cs.onBackground, fontSize: 28, fontWeight: FontWeight.w700)
            ),
            const SizedBox(height: 16),
            
            // Demo credentials info card
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cs.primary.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: cs.primary, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context).demoCredentials,
                        style: TextStyle(
                          color: cs.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${AppLocalizations.of(context).useAnyEmailPassword}\n${AppLocalizations.of(context).example}',
                    style: TextStyle(
                      color: cs.onBackground.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03), // Responsive spacing
            Text(AppLocalizations.of(context).emailAddress, style: TextStyle(color: cs.onBackground.withValues(alpha: 0.7))),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'user@example.com',
                filled: true,
                fillColor: cs.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context).password, style: TextStyle(color: cs.onBackground.withValues(alpha: 0.7))),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: _obscure,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                ),
                hintText: 'password123',
                filled: true,
                fillColor: cs.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.pushFade(const ForgotScreen());
                },
                child: Text(AppLocalizations.of(context).forgotPassword),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _handleRegularLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text(AppLocalizations.of(context).signIn, style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 16),
            
            // Biometric Authentication Section
            Consumer<BiometricProvider>(
              builder: (context, biometricProvider, child) {
                if (biometricProvider.isBiometricEnabled && biometricProvider.isBiometricAvailable) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Divider(color: cs.onBackground.withValues(alpha: 0.3))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              AppLocalizations.of(context).or,
                              style: TextStyle(
                                color: cs.onBackground.withValues(alpha: 0.6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: cs.onBackground.withValues(alpha: 0.3))),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: () => _handleBiometricLogin(biometricProvider),
                          icon: Icon(
                            Icons.fingerprint,
                            color: cs.primary,
                          ),
                          label: Text(
                            AppLocalizations.of(context).signInWithBiometric(biometricProvider.biometricTypeName),
                            style: TextStyle(
                              color: cs.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: cs.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            
            const Flexible(child: SizedBox(height: 20)),
            Center(
              child: TextButton(
                onPressed: () {
                  context.pushFade(const RegisterScreen());
                },
                child: Text(AppLocalizations.of(context).newUserSignUp),
              ),
            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
