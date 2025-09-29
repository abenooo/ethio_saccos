import 'package:flutter/material.dart';

class FaydaPrintDemoScreen extends StatefulWidget {
  const FaydaPrintDemoScreen({super.key});

  @override
  State<FaydaPrintDemoScreen> createState() => _FaydaPrintDemoScreenState();
}

class _FaydaPrintDemoScreenState extends State<FaydaPrintDemoScreen> {
  int step = 0;
  final _fanController = TextEditingController();
  final _otpController = TextEditingController();
  bool consent = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        title: const Text('Fayda Card Print (Demo)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: cs.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _steps(context),
            const SizedBox(height: 12),
            Expanded(child: _content(context)),
            const SizedBox(height: 8),
            Row(
              children: [
                if (step > 0)
                  OutlinedButton(
                    onPressed: () => setState(() => step--),
                    child: const Text('Back'),
                  ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(step == 4 ? 'Finish' : 'Next'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _steps(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final titles = ['FAN', 'OTP', 'Review', 'Delivery', 'Success'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(titles.length, (i) {
        final active = i <= step;
        return Column(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: active ? cs.primary : cs.onBackground.withValues(alpha: 0.2),
              child: Text('${i + 1}', style: TextStyle(color: active ? cs.onPrimary : cs.background, fontSize: 12)),
            ),
            const SizedBox(height: 4),
            Text(titles[i], style: TextStyle(color: cs.onBackground.withValues(alpha: 0.7), fontSize: 12)),
          ],
        );
      }),
    );
  }

  Widget _content(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    switch (step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please enter your Fayda Alias Number (FAN).', style: TextStyle(color: cs.onBackground)),
            const SizedBox(height: 8),
            TextField(
              controller: _fanController,
              decoration: InputDecoration(
                hintText: 'FAN-XXXXXXXXXX',
                filled: true,
                fillColor: cs.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter the 6-digit OTP sent to your phone.', style: TextStyle(color: cs.onBackground)),
            const SizedBox(height: 8),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '••••••',
                filled: true,
                fillColor: cs.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Review demographics (demo):', style: TextStyle(color: cs.onBackground, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _reviewRow('Name', 'Abebe Bekele'),
            _reviewRow('FAN', _fanController.text.isEmpty ? 'FAN-XXXXXXXXXX' : _fanController.text),
            _reviewRow('Phone', '+251 9xx xxx xxx'),
            _reviewRow('Woreda/Kebele', 'Addis Ababa / 01'),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(value: consent, onChanged: (v) => setState(() => consent = v ?? false)),
                Expanded(child: Text('I consent to the terms and conditions.', style: TextStyle(color: cs.onBackground.withValues(alpha: 0.8))))
              ],
            )
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose delivery and payment (demo):', style: TextStyle(color: cs.onBackground, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              items: const [DropdownMenuItem(value: 'Branch', child: Text('Pickup at Branch')), DropdownMenuItem(value: 'Courier', child: Text('Courier Delivery'))],
              onChanged: (_) {},
              decoration: InputDecoration(filled: true, fillColor: cs.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              items: const [DropdownMenuItem(value: 'Addis Ababa', child: Text('Addis Ababa')), DropdownMenuItem(value: 'Adama', child: Text('Adama'))],
              onChanged: (_) {},
              decoration: InputDecoration(filled: true, fillColor: cs.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
            ),
            const SizedBox(height: 12),
            Text('Payment: ETB 150.00 (demo)', style: TextStyle(color: cs.onBackground)),
          ],
        );
      default:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 56),
              const SizedBox(height: 12),
              Text('You have successfully placed an order.', style: TextStyle(color: cs.onBackground, fontWeight: FontWeight.w600)),
            ],
          ),
        );
    }
  }

  Widget _reviewRow(String label, String value) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: TextStyle(color: cs.onBackground.withValues(alpha: 0.7)))) ,
          Expanded(child: Text(value, style: TextStyle(color: cs.onBackground)))
        ],
      ),
    );
  }

  void _next() {
    if (step < 4) setState(() => step++);
  }
}
