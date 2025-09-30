import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/theme.dart';
import '../services/navigation_service.dart';
import '../providers/card_data_provider.dart';
import '../../features/home/screens/transaction_details_screen.dart' as details;
import '../../features/loans/screens/loan_details_screen.dart';

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
  static const _kCardHeight = 180.0;
  
  final PageController _pageController = PageController(viewportFraction: _kViewportFraction);
  int _currentPage = 0;
  bool _obscure = true;

  // Use centralized card data for consistency and performance
  late final List<CardData> _cards = CardDataProvider.allCardData.map((cardMap) => 
    CardData(
      title: cardMap['title'] as String,
      amount: cardMap['amount'] as String,
      info1: cardMap['info1'] as String,
      info2: cardMap['info2'] as String,
      icon: _getIconForCard(cardMap['title'] as String),
    )
  ).toList();

  // Helper method to get appropriate icon for each card type
  IconData _getIconForCard(String title) {
    switch (title.toLowerCase()) {
      case 'abenezer kifle':
        return Icons.account_balance_wallet;
      case 'personal loan':
        return Icons.account_balance;
      case 'savings account':
        return Icons.savings;
      case 'share account':
        return Icons.pie_chart;
      default:
        return Icons.credit_card;
    }
  }

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
    final palette = Theme.of(context).extension<AppPalette>()!;
    final color = isSelected ? palette.dotActive : palette.dotInactive;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: isSelected ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
    );
  }

  Widget _buildCard(CardData card) {
    final isLoan = card.title.toLowerCase().contains('loan');
    final isShare = card.title.toLowerCase().contains('share');

    final String displayedAmount = _obscure 
        ? '*********************' 
        : (isLoan ? '- ${card.amount}' : card.amount);

    // Premium gradient for each card type
    Gradient cardGradient;
    if (isLoan) {
      cardGradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFDC2626), Color(0xFFEA580C)], // Error red to warning orange
      );
    } else if (isShare) {
      cardGradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFD97706), Color(0xFFEA580C)], // Accent gold to warning orange
      );
    } else {
      cardGradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)], // Primary blue to light blue
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _handleCardTap(context, card, isLoan, isShare),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: cardGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCardHeader(card),
            Text(
              displayedAmount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildCardFooter(card),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader(CardData card) {
    return Row(
      children: [
        Icon(
          card.icon,
          color: Colors.white.withOpacity(0.9),
          size: 24,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            card.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.white.withOpacity(0.9),
            size: 22,
          ),
          onPressed: () => setState(() => _obscure = !_obscure),
          splashRadius: 18,
        ),
      ],
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
                _obscure ? '•••• •••• •••• ${card.info1.length >= 4 ? card.info1.substring(card.info1.length - 4) : card.info1}' : card.info1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                card.info2,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
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
            const Text(
              'ETHIO SACCOS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat.yMMMd().add_Hm().format(DateTime.now()),
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
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

// Extension for optimized card tap handling
extension CardCarouselNavigation on _CardCarouselState {
  // Optimized card tap handler using centralized navigation service
  void _handleCardTap(BuildContext context, CardData card, bool isLoan, bool isShare) {
    if (isLoan) {
      // Navigate to Loans screen with loan card data
      NavigationService.navigateToLoansWithCardData(context, card);
    } else if (isShare || card.title.toLowerCase().contains('savings') || card.title == 'Abenezer Kifle') {
      // Navigate to Savings screen with main account data
      NavigationService.navigateToSavingsWithCardData(context, _cards);
    } else {
      // Navigate to transaction details for other cards
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => details.TransactionDetailsScreen(
            title: card.title,
            isLoan: isLoan,
            isShare: isShare,
          ),
        ),
      );
    }
  }
}
