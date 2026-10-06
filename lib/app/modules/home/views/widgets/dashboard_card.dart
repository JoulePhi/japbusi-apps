import 'package:flutter/material.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String mainValue;
  final String subtitle;
  final String subValue;
  final Color backgroundColor;
  final IconData icon;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.mainValue,
    required this.subtitle,
    required this.subValue,
    required this.backgroundColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body1.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 20, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 8),
          // Main value
          Text(
            mainValue,
            style: AppTextStyles.body1.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle and sub value
          Text(
            subtitle,
            style: AppTextStyles.body1.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            subValue,
            style: AppTextStyles.body1.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
