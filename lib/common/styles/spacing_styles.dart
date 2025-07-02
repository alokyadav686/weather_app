import 'package:flutter/material.dart';
import 'package:weather_app/common/utils/contants/sizes.dart';

class AppSpacingStyles {
  
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight,
    left: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace,
  );
  
  static const sidePadding = EdgeInsets.symmetric(
    horizontal: AppSizes.defaultSpace,
  );
}