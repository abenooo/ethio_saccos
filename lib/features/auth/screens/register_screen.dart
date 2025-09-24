import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: cs.onBackground,
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Image.asset('asset/app_logo.png', width: 56, height: 56),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Demo National ID integration', style: TextStyle(color: cs.onBackground, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text('Use your national ID to quickly create an account. (Demo flow)', style: TextStyle(color: cs.onBackground.withValues(alpha: 0.7))),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.verified_user_outlined),
                      label: const Text('Continue with National ID (Demo)'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: cs.onBackground,
                        side: BorderSide(color: cs.onBackground.withValues(alpha: 0.2)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _field(context, Icons.person_outline, 'Full Name'),
            const SizedBox(height: 12),
            _field(context, Icons.email_outlined, 'Email Address'),
            const SizedBox(height: 12),
            _field(context, Icons.phone, 'Phone Number'),
            const SizedBox(height: 12),
            _field(context, Icons.lock_outline, 'Password', obscure: true),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(BuildContext context, IconData icon, String hint, {bool obscure = false}) {
    final cs = Theme.of(context).colorScheme;
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: cs.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
