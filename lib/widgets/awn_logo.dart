import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AwnLogo extends StatelessWidget {
  const AwnLogo({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.22),
        boxShadow: [
          BoxShadow(
            color: AppColors.olive.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Icon(
        Icons.volunteer_activism_rounded,
        size: size * 0.52,
        color: AppColors.olive,
      ),
    );
  }
}
