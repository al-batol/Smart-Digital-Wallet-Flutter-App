import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/account_card_widget.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/decorative_circles_widget.dart';

class AccountCardsCarouselWidget extends StatefulWidget {
  final double height;
  final List<AccountEntity> accounts;
  const AccountCardsCarouselWidget({
    super.key,
    required this.height,
    required this.accounts,
  });

  @override
  State<AccountCardsCarouselWidget> createState() =>
      _AccountCardsCarouselWidgetState();
}

class _AccountCardsCarouselWidgetState
    extends State<AccountCardsCarouselWidget> {
  late final PageController _pageController;
  late double _currentPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentPage = 0;
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageController.removeListener(_onPageChanged);
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      _currentPage = _pageController.page ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.accounts.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: Text('No accounts available')),
      );
    }

    return SizedBox(
      height: widget.height,
      width: ResponsiveHelper.screenWidth(context),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.accounts.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: ResponsiveHelper.screenWidth(context),
                    height: widget.height,
                    color: cardGradientStartColor.withValues(alpha: 0.15),
                  ),
                  DecorativeCirclesWidget(
                    height: widget.height,
                    disableLeftCircle: index == 0,
                    disableRightCircle: index == widget.accounts.length - 1,
                  ),
                  Positioned(
                    top: widget.height * 0.1,
                    left: AppDimensions.paddingLg.width(context),
                    right: AppDimensions.paddingLg.width(context),
                    child: AccountCardWidget(
                      account: widget.accounts[index],
                      height: widget.height,
                    ),
                  ),
                ],
              );
            },
          ),
          if (widget.accounts.length > 1)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DotsIndicator(
                dotsCount: widget.accounts.length,
                position: _currentPage,
                decorator: DotsDecorator(
                  color: accentOrangeColor,
                  activeColor: primaryColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
