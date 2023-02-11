import 'package:flutter/material.dart';

import 'md_app_colors.dart';

class AppFontStyles {
  static const text17Black = TextStyle(
    color: AppColors.mdBlackColor,
    fontSize: 17,
  );

  static const semiBold15Black = TextStyle(
    color: AppColors.mdBlackColor,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  static const normal17Black = TextStyle(
      color: AppColors.mdBlackColor,
      fontWeight: FontWeight.normal,
      fontSize: 17);

  static const semBold17Black = TextStyle(
      color: AppColors.mdBlackColor, fontWeight: FontWeight.w500, fontSize: 17);

  static const semiBold18Black = TextStyle(
      color: AppColors.mdBlackColor, fontWeight: FontWeight.w500, fontSize: 18);

  static const underlinedBold18DarkBlue = TextStyle(
    color: AppColors.mdDarkBlueColor,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    fontSize: 18,
  );

  static const semiBold19Black = TextStyle(
      color: AppColors.mdBlackColor, fontWeight: FontWeight.w500, fontSize: 19);

  static const normal19Black = TextStyle(
      color: AppColors.mdBlackColor,
      fontWeight: FontWeight.normal,
      fontSize: 19);

  static const normal20Black = TextStyle(
      color: AppColors.mdBlackColor,
      fontWeight: FontWeight.normal,
      fontSize: 20);

  static const semiBold20Black = TextStyle(
      color: AppColors.mdBlackColor, fontWeight: FontWeight.w600, fontSize: 20);

  static const normal20White = TextStyle(
      color: AppColors.mdWhiteColor,
      fontWeight: FontWeight.normal,
      fontSize: 20);

  static const semiBold22Black = TextStyle(
      color: AppColors.mdBlackColor, fontWeight: FontWeight.w600, fontSize: 22);

  static const semiBold22White = TextStyle(
    color: AppColors.mdWhiteColor,
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );

  static const textSize17 = TextStyle(fontSize: 17);

  static const bold35Black = TextStyle(
      color: AppColors.mdBlackColor, fontWeight: FontWeight.bold, fontSize: 35);

  static const iconArrowBack =
      Icon(Icons.arrow_back_ios, color: AppColors.mdBlackColor);

  static const iconRightArrow = Icon(
    Icons.chevron_right,
    color: AppColors.mdBlackColor,
    size: 28,
  );

  static const iconLeftrrow = Icon(
    Icons.chevron_left,
    color: AppColors.mdBlackColor,
    size: 28,
  );
}