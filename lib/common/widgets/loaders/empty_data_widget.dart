import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class TEmptyDataWidget extends StatelessWidget {
  const TEmptyDataWidget({
    super.key,
    required this.text,
    this.image = TImages.deliveredInPlaneIllustration,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String image;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: MediaQuery.of(context).size.width * 0.8),
          const SizedBox(height: TSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.defaultSpace),
          if (showAction && actionText != null)
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                child: Text(actionText!),
              ),
            ),
        ],
      ),
    );
  }
}
