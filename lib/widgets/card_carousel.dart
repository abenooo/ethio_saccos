import 'package:flutter/material.dart';

class CardCarousel extends StatefulWidget {
  final bool isDark;
  final Gradient cardGradient;

  const CardCarousel({
    super.key,
    required this.isDark,
    required this.cardGradient,
  });

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  static const _kViewportFraction = 0.95;
  static const _kCardHeight = 240.0;
  
  final PageController _pageController = PageController(viewportFraction: _kViewportFraction);
  int _currentPage = 0;

  final List<CardData> _cards = [
    CardData(
      title: 'Savings Account',
      amount: 'ETB 25,000.00',
      info1: 'Member since: Jan 2024',
      info2: 'Last transaction: Today, 10:30 AM',
      icon: Icons.savings,
    ),
    CardData(
      title: 'Loan Account',
      amount: 'ETB 100,000.00',
      info1: 'Due date: March 30, 2024',
      info2: 'Interest rate: 12% p.a',
      icon: Icons.account_balance_wallet,
    ),
    CardData(
      title: 'Share Account',
      amount: '250 Shares',
      info1: 'Value: ETB 25,000',
      info2: 'Dividend rate: 15%',
      icon: Icons.pie_chart,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: _kCardHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _cards.length,
            itemBuilder: (context, index) => _buildCard(_cards[index]),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _cards.length,
            (index) => _buildDotIndicator(index),
          ),
        ),
      ],
    );
  }

  Widget _buildDotIndicator(int index) {
    final isSelected = _currentPage == index;
    final color = isSelected
        ? (widget.isDark ? Colors.white : Colors.blue[700])
        : (widget.isDark ? Colors.white.withOpacity(0.3) : Colors.blue.withOpacity(0.2));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildCard(CardData card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: widget.cardGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(card),
          const Spacer(),
          _buildAmount(card.amount),
          const SizedBox(height: 20),
          _buildCardFooter(card),
        ],
      ),
    );
  }

  Widget _buildCardHeader(CardData card) {
    return Row(
      children: [
        Icon(
          card.icon,
          color: widget.isDark ? Colors.white70 : Colors.white,
          size: 24,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            card.title,
            style: TextStyle(
              color: widget.isDark ? Colors.white70 : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Icon(
          Icons.verified_user,
          color: widget.isDark ? Colors.white70 : Colors.white,
          size: 24,
        ),
      ],
    );
  }

  Widget _buildAmount(String amount) {
    return Text(
      amount,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildCardFooter(CardData card) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card.info1,
                style: TextStyle(
                  color: widget.isDark ? Colors.white70 : Colors.white,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                card.info2,
                style: TextStyle(
                  color: widget.isDark ? Colors.white60 : Colors.white70,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'ETHIO SACCOS',
              style: TextStyle(
                color: widget.isDark ? Colors.white70 : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateTime.now().toString().substring(0, 16),
              style: TextStyle(
                color: widget.isDark ? Colors.white60 : Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class CardData {
  final String title;
  final String amount;
  final String info1;
  final String info2;
  final IconData icon;

  const CardData({
    required this.title,
    required this.amount,
    required this.info1,
    required this.info2,
    required this.icon,
  });
}
