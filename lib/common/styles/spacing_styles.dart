import 'package:flutter/cupertino.dart';

import '../../utils/constants/sizes.dart';

class TSpacingStyles{
  static const EdgeInsetsGeometry paddingWithAppbarHeight = EdgeInsets.only(
      top: TSizes.appBarHeight,
      left: TSizes.defaultSpace,
      right: TSizes.defaultSpace,
      bottom: TSizes.defaultSpace
  );
}