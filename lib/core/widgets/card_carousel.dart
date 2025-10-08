import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../features/home/screens/transaction_details_screen.dart' as details;
import '../../features/loans/screens/loan_details_screen.dart';
import '../theme/theme.dart';
import '../services/navigation_service.dart';
import '../utils/page_transitions.dart';
import '../providers/card_data_provider.dart';
import '../../generated/l10n/app_localizations.dart';

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
  
  late final PageController _pageController;
  int _currentPage = 0;
  
  // Individual visibility state for each card
  late final List<bool> _cardVisibility;

  // Cache card data for better performance
  late final List<CardData> _cards;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: _kViewportFraction);
    // Initialize cards once for optimal performance
    _cards = CardDataProvider.allCardData.map((cardMap) => 
      CardData(
        title: cardMap['title'] as String,
        amount: cardMap['amount'] as String,
        info1: cardMap['info1'] as String,
        info2: cardMap['info2'] as String,
        icon: _getIconForCard(cardMap['title'] as String),
      )
    ).toList();
    
    // Initialize visibility state for each card (all hidden by default)
    _cardVisibility = List.filled(_cards.length, false);
  }

  // Helper method to get appropriate icon for each card type
  IconData _getIconForCard(String title) {
    switch (title.toLowerCase()) {
      case 'abenezer kifle':
        return Icons.account_balance_wallet;
      case 'personalloan':
        return Icons.account_balance;
      case 'shareaccount':
        return Icons.pie_chart;
      case 'regularsavings':
        return Icons.savings;
      case 'fixeddeposit':
        return Icons.trending_up;
      case 'emergencyfund':
        return Icons.emergency;
      case 'childreneducation':
        return Icons.school;
      case 'holidaysavings':
        return Icons.beach_access;
      default:
        return Icons.savings;
    }
  }

  // Helper method to get localized title
  String _getLocalizedTitle(BuildContext context, String titleKey) {
    final l10n = AppLocalizations.of(context);
    switch (titleKey) {
      case 'personalLoan':
        return l10n.personalLoan;
      case 'shareAccount':
        return l10n.shareAccount;
      case 'regularSavings':
        return l10n.regularSavings;
      case 'fixedDeposit':
        return l10n.fixedDeposit;
      case 'emergencyFund':
        return l10n.emergencyFund;
      case 'childrenEducation':
        return l10n.childrenEducation;
      case 'holidaySavings':
        return l10n.holidaySavings;
      case 'mainAccount':
        return l10n.mainAccount;
      // If it's a person's name (contains space), return as is
      default:
        return titleKey.contains(' ') ? titleKey : titleKey; // Keep names unchanged
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
            itemBuilder: (context, index) => _buildCard(_cards[index], index),
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

  // Use theme-based gradients for consistency

  Widget _buildCard(CardData card, int cardIndex) {
    final isLoan = card.title.toLowerCase().contains('loan');
    final isShare = card.title.toLowerCase().contains('share');
    final isSavings = card.title.toLowerCase().contains('savings') || 
                      card.title.toLowerCase().contains('fixed') ||
                      card.title.toLowerCase().contains('emergency') ||
                      card.title.toLowerCase().contains('education') ||
                      card.title.toLowerCase().contains('holiday');

    final String displayedAmount = _cardVisibility[cardIndex] 
        ? (isLoan ? '- ${card.amount}' : card.amount)
        : '*********************';

    // Use theme gradient for all cards
    final gradients = Theme.of(context).extension<AppGradients>()!;
    final Gradient cardGradient = gradients.cardGradient;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _handleCardTap(context, card, isLoan, isShare),
          child: Ink(
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
                _buildCardHeader(card, cardIndex),
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
        ),
      ),
    );
  }

  Widget _buildCardHeader(CardData card, int cardIndex) {
    return Row(
      children: [
        Icon(
          card.icon,
          color: Colors.white.withValues(alpha: 0.9),
          size: 24,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            _getLocalizedTitle(context, card.title),
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
            _cardVisibility[cardIndex] ? Icons.visibility : Icons.visibility_off,
            color: Colors.white.withValues(alpha: 0.9),
            size: 22,
          ),
          onPressed: () => setState(() => _cardVisibility[cardIndex] = !_cardVisibility[cardIndex]),
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
                card.info1,
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

/// Immutable data class representing a financial card
/// 
/// Used for displaying account information in the card carousel.
/// Immutability ensures thread-safety and better performance.
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardData &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          amount == other.amount;

  @override
  int get hashCode => Object.hash(title, amount);
}

// Extension for optimized card tap handling
extension CardCarouselNavigation on _CardCarouselState {
  // Optimized card tap handler using centralized navigation service
  void _handleCardTap(BuildContext context, CardData card, bool isLoan, bool isShare) {
    // Check if it's any savings-type card
    final isSavingsType = isShare || 
                          card.title.toLowerCase().contains('savings') ||
                          card.title.toLowerCase().contains('fixed') ||
                          card.title.toLowerCase().contains('emergency') ||
                          card.title.toLowerCase().contains('education') ||
                          card.title.toLowerCase().contains('holiday') ||
                          card.title == 'Abenezer Kifle';
    
    if (isLoan) {
      // Navigate to Loans screen with loan card data
      NavigationService.navigateToLoansWithCardData(context, card);
    } else if (isSavingsType) {
      // Navigate to Savings screen with all savings data
      NavigationService.navigateToSavingsWithCardData(context, _cards);
    } else {
      // Navigate to transaction details for other cards
      context.pushFade(
        details.TransactionDetailsScreen(
          title: card.title,
          isLoan: isLoan,
          isShare: isShare,
        ),
      );
    }
  }
}
