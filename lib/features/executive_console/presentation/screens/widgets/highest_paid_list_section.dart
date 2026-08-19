import 'package:flutter/material.dart';
import '../../../data/models/employee_model.dart';
import '../../../../../core/theme/app_tokens.dart';
import 'employee_list_item_widget.dart';

class HighestPaidListSection extends StatelessWidget {
  final List<Employee> employees;

  const HighestPaidListSection({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Highest Paid',
          style: AppTypography.headlineMd.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        Divider(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
          height: 1.0,
          thickness: 1.0,
        ),
        const SizedBox(height: AppSpacing.stackGap),
        ...employees.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: EmployeeListItemWidget(employee: e, isHighestPaid: true),
          ),
        ),
      ],
    );
  }
}
