import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;
  final Function() onTap;
  final BorderRadius? borderRadius;
  final bool elevated;
  const CustomCard({
    super.key,
    required this.child,
    required this.onTap,
    required this.borderRadius,
     required this.elevated
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: elevated
      ? BoxDecoration(
        borderRadius: borderRadius,
        color: AppColors.primaryBlue500,


      )
        : BoxDecoration(
        borderRadius: borderRadius,
        color: AppColors.primaryBlue500,

      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: child,
        ),
    ),

    );
  }
}
