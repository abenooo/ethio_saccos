import 'package:flutter/material.dart';

class ChatSupportSheet extends StatefulWidget {
  const ChatSupportSheet({super.key});

  @override
  State<ChatSupportSheet> createState() => _ChatSupportSheetState();
}

class _ChatSupportSheetState extends State<ChatSupportSheet> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = <_ChatMessage>[];

  @override
  void initState() {
    super.initState();
    // Seed greeting and main menu quick action
    final now = TimeOfDay.now();
    _messages.add(
      _ChatMessage(
        text:
            'Hello and Welcome!\n\nI\'m Selam, your Ethio SACCO digital assistant. I\'m here to help with membership, savings, loans, transfers and other SACCO services. How can I assist you today?',
        isMe: false,
        time: now,
        quickReplies: const ['Main Menu'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Grab handle
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onBackground.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
                    child: Icon(Icons.support_agent, color: colorScheme.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SACCO Support',
                          style: TextStyle(
                            color: colorScheme.onBackground,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Typically replies in a few minutes',
                          style: TextStyle(
                            color: colorScheme.onBackground.withValues(alpha: 0.6),
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: colorScheme.onBackground.withValues(alpha: 0.7)),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
            const Divider(height: 1),
            // Messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _MessageBubble(
                    message: msg,
                    onQuickTap: _handleQuickReply,
                  );
                },
              ),
            ),
            // Input
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file, color: colorScheme.onSurface.withValues(alpha: 0.7)),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.background,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.08)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Type your message... ',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: colorScheme.primary,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _send,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.send, color: colorScheme.onPrimary, size: 20),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(text: text, isMe: true, time: TimeOfDay.now()));
    });
    _controller.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    _autoRespond(text);
  }

  void _handleQuickReply(String label) {
    switch (label) {
      case 'Main Menu':
        setState(() {
          _messages.add(
            _ChatMessage(
              text: 'Choose an option to continue:',
              isMe: false,
              time: TimeOfDay.now(),
              quickReplies: const [
                'SACCO Services',
                'Member Self Service',
                'Exchange Rate',
                'Contact Us',
                'FAQs',
                'About SACCO',
                'Change Language',
              ],
            ),
          );
        });
        break;
      case 'SACCO Services':
        setState(() {
          _messages.add(
            _ChatMessage(
              text: 'Please select from the following SACCO services to learn more:',
              isMe: false,
              time: TimeOfDay.now(),
              quickReplies: const [
                'Savings & Deposits',
                'Loans',
                'Transfers',
                'Other Services',
              ],
            ),
          );
        });
        break;
      case 'Savings & Deposits':
        setState(() {
          _messages.add(
            _ChatMessage(
              isMe: false,
              time: TimeOfDay.now(),
              text:
                  'Our SACCO offers a range of member‑focused savings and deposit products:\n\nPersonal Savings: Interest‑bearing savings you can manage via passbook or mobile. Variants include:\n• Ordinary Savings\n• Women Savings\n• Youth Savings\n• Teen/Student Savings\n• Education Savings\n• Wedding Savings\n• Holiday Savings\n• Child/Minor Savings\n• Group/Association Savings\n\nCurrent (Demand) Accounts: Non‑interest accounts designed for frequent transactions.\n\nFixed‑Time Deposits: Lock funds for an agreed term and earn higher returns than regular savings. Minimum initial deposit and terms apply.\n\nForeign‑Currency or Diaspora Savings: For eligible members to hold or save funds in USD/GBP/EUR where regulation permits.',
            ),
          );
        });
        break;
      case 'Loans':
        setState(() {
          _messages.add(
            _ChatMessage(
              isMe: false,
              time: TimeOfDay.now(),
              text:
                  'Loans tailored for members and groups:\n\n• Micro & SME Loans – working capital, inventory or equipment.\n• Emergency Loans – fast access for urgent personal needs.\n• Education Loans – tuition, materials and related costs.\n• Agricultural Loans – inputs, livestock, irrigation, post‑harvest.\n• Asset/Auto Loans – purchase of productive assets or vehicles.\n• Group Lending – solidarity/group guaranteed financing.\n\nEligibility typically requires active membership, regular savings history and ability to repay. Rates, collateral and maximum amounts vary by product and SACCO policy.',
            ),
          );
        });
        break;
      case 'Transfers':
        setState(() {
          _messages.add(
            _ChatMessage(
              isMe: false,
              time: TimeOfDay.now(),
              text:
                  'Transfer options for members:\n\n• Internal Transfer – move funds between your SACCO accounts.\n• Member‑to‑Member – send to another SACCO member.\n• Bank/Wallet Transfer – to linked bank accounts or mobile wallets (where enabled).\n\nFees and limits depend on channel and destination. Instant alerts available via mobile app/SMS.',
            ),
          );
        });
        break;
      case 'Member Self Service':
        setState(() {
          _messages.add(
            _ChatMessage(
              isMe: false,
              time: TimeOfDay.now(),
              text:
                  'Member Self Service lets you:\n\n• Check balances and mini statements\n• Download account statements\n• Open new savings goals\n• Initiate deposits/withdrawal requests\n• Apply for loans and track status\n• Update profile and KYC\n\nAccess via the mobile app or web portal with your member credentials.',
            ),
          );
        });
        break;
      case 'Exchange Rate':
        setState(() {
          _messages.add(
            _ChatMessage(
              isMe: false,
              time: TimeOfDay.now(),
              text:
                  'Exchange Rate:\nFor the latest indicative FX rates used by the SACCO and partner institutions, please see the Rates page in the app or contact your branch. Rates are subject to change throughout the day.',
            ),
          );
        });
        break;
      case 'Contact Us':
        setState(() {
          _messages.add(
            _ChatMessage(
              isMe: false,
              time: TimeOfDay.now(),
              text:
                  'Contact Us:\n• Call Center: 9-5 on working days\n• Email: support@ethiosacco.example\n• Branches: Find the nearest branch in the app under Locations\n• WhatsApp/Telegram (where available): See Support in Settings',
            ),
          );
        });
        break;
      case 'FAQs':
        setState(() {
          _messages.add(
            _ChatMessage(
              isMe: false,
              time: TimeOfDay.now(),
              text:
                  'Frequently Asked Questions:\n• How do I become a member?\n  – Fill the membership form, provide KYC and initial savings.\n• How are dividends/interest calculated?\n  – Based on product terms and your average balance.\n• How fast are loans processed?\n  – Depends on product; many processed within 1–3 working days after documents.\n• Can I use the mobile app without visiting a branch?\n  – Yes, for most services once your KYC is verified.',
            ),
          );
        });
        break;
      case 'About SACCO':
        setState(() {
          _messages.add(
            _ChatMessage(
              isMe: false,
              time: TimeOfDay.now(),
              text:
                  'About Ethio SACCO:\nMember‑owned cooperative providing accessible savings, affordable credit and financial literacy to communities. We prioritize member value, transparency and sustainable development.',
            ),
          );
        });
        break;
      case 'Change Language':
        setState(() {
          _messages.add(
            _ChatMessage(
              isMe: false,
              time: TimeOfDay.now(),
              text:
                  'Select your preferred language:\n• English\n• Amharic\n• Afaan Oromo\n• Tigrinya\n(Interface will update after selection.)',
            ),
          );
        });
        break;
      default:
        setState(() {
          _messages.add(
            _ChatMessage(
              text: 'Thanks! I\'ll connect you to more info about "$label" shortly.',
              isMe: false,
              time: TimeOfDay.now(),
            ),
          );
        });
    }
    _scrollToEnd();
  }

  void _autoRespond(String userText) {
    // Lightweight intent matching
    final text = userText.toLowerCase();
    if (text.contains('menu')) {
      _handleQuickReply('Main Menu');
      return;
    }
    if (text.contains('deposit') || text.contains('saving')) {
      _handleQuickReply('Savings & Deposits');
      return;
    }
    if (text.contains('service')) {
      _handleQuickReply('SACCO Services');
      return;
    }
    if (text.contains('loan')) {
      _handleQuickReply('Loans');
      return;
    }
    if (text.contains('transfer')) {
      _handleQuickReply('Transfers');
      return;
    }
    if (text.contains('faq')) {
      _handleQuickReply('FAQs');
      return;
    }
    if (text.contains('about')) {
      _handleQuickReply('About SACCO');
      return;
    }
    if (text.contains('contact')) {
      _handleQuickReply('Contact Us');
      return;
    }
    if (text.contains('language')) {
      _handleQuickReply('Change Language');
      return;
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

class _ChatMessage {
  final String text;
  final bool isMe;
  final TimeOfDay time;
  final List<String>? quickReplies;
  _ChatMessage({required this.text, required this.isMe, required this.time, this.quickReplies});
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;
  final void Function(String label)? onQuickTap;
  const _MessageBubble({required this.message, this.onQuickTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final align = message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bg = message.isMe ? cs.primary : cs.surface;
    final fg = message.isMe ? cs.onPrimary : cs.onSurface;

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: message.isMe ? const Radius.circular(16) : const Radius.circular(4),
              bottomRight: message.isMe ? const Radius.circular(4) : const Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(message.text, style: TextStyle(color: fg, fontSize: 14)),
        ),
        if (message.quickReplies != null && message.quickReplies!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 6, right: 6),
            child: Wrap(
              spacing: 8,
              runSpacing: 6,
              children: message.quickReplies!
                  .map(
                    (label) => ActionChip(
                      label: Text(label),
                      onPressed: () => onQuickTap?.call(label),
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
          )
      ],
    );
  }
}
