import 'package:employee_management_system/core/helpers/format_currency.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_tokens.dart';

class AnalyticsOverviewSection extends StatelessWidget {
  final double avgSalary;
  final double? highestPaidSalary;

  const AnalyticsOverviewSection({
    super.key,
    required this.avgSalary,
    required this.highestPaidSalary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'ANALYTICS OVERVIEW',
            style: AppTypography.labelMd.copyWith(
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: _KpiCard(salary: avgSalary, label: 'AVG Salary'),
              ),
              const SizedBox(width: AppSpacing.stackGap),
              Expanded(
                child: _KpiCard(
                  salary: highestPaidSalary,
                  label: 'HIGHEST Salary',
                  isHighest: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  final double? salary;
  final String label;
  final bool isHighest;
  const _KpiCard({
    required this.salary,
    required this.label,
    this.isHighest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(width: 3.5, color: AppColors.primaryContainer),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 14.0, 14.0, 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isHighest) ...[
                      const Icon(
                        Icons.verified_outlined,
                        size: 16.0,
                        color: AppColors.primary,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  formatCurrency(salary),
                  style: AppTypography.headlineMd.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
