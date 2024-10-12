import 'package:book_app/components/app_box_shadow.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    this.text = "text",
    this.icon,
    this.height = 45.0,
    this.bgColor = AppColors.bgColor,
    this.boderColor = AppColors.black,
    this.borderRadius = const BorderRadius.all(Radius.circular(15.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
  });

  const AppButton.ouline({
    super.key,
    this.onTap,
    this.text = "text",
    this.icon,
    this.height = 45.0,
    this.bgColor = AppColors.bgColor,
    this.boderColor = AppColors.black,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
  });

  final Function()? onTap;
  final String text;
  final Icon? icon;
  final double height;
  final BorderRadius borderRadius;
  final Color bgColor;
  final Color boderColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          border: Border.all(color: AppColors.black),
          borderRadius: borderRadius,
          boxShadow: AppBoxShadow.boxShadow
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 4.0),
            ],
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }
}
