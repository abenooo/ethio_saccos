import 'package:flutter/material.dart';
import 'chat_support_sheet.dart';

class FloatingChatButton extends StatefulWidget {
  const FloatingChatButton({super.key});

  @override
  State<FloatingChatButton> createState() => _FloatingChatButtonState();
}

class _FloatingChatButtonState extends State<FloatingChatButton> {
  Offset position = const Offset(16, 200);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Positioned(
      right: 16,
      bottom: 24, // lower, closer to bottom like Telegram
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const FractionallySizedBox(
              heightFactor: 0.9,
              child: ChatSupportSheet(),
            ),
          );
        },
        child: _buildButton(cs),
      ),
    );
  }

  Widget _buildButton(ColorScheme cs) {
    return Material(
      elevation: 8,
      shape: const CircleBorder(),
      color: cs.primary,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Icon(Icons.chat_bubble_rounded, color: cs.onPrimary, size: 26),
      ),
    );
  }
}
