
import 'package:flutter/material.dart';

import '../../../utils/constants/enums.dart';

class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText({
    super.key,
    required this.title,
    this.textColor,
    this.textAlign = TextAlign.center,
    this.maxLines = 1,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final Color? textColor;
  final TextAlign? textAlign;
  final int maxLines;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: brandTextSize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: textColor)
          : brandTextSize == TextSizes.medium
          ? Theme.of(context).textTheme.bodyLarge!.apply(color: textColor)
          : brandTextSize == TextSizes.large
          ? Theme.of(context).textTheme.titleLarge!.apply(color: textColor)
          : Theme.of(context).textTheme.bodyMedium!.apply(color: textColor),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}