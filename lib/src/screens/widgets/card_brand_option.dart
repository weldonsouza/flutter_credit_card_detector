import 'package:flutter/material.dart';

class CardBrandOption extends StatelessWidget {
  final String image;
  final bool isSelected;
  final Color selectedColor;
  final Color? imageTint;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double imageSize;

  const CardBrandOption({
    super.key,
    required this.image,
    required this.isSelected,
    required this.selectedColor,
    this.imageTint,
    required this.onTap,
    required this.width,
    required this.height,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? selectedColor.withAlpha(160)
                : Colors.grey.withAlpha(90),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(isSelected ? 35 : 18),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image(
            image: AssetImage(
              'assets/$image.png',
              package: 'flutter_credit_card_detector',
            ),
            width: imageSize,
            height: imageSize,
            color: imageTint,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
