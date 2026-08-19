import 'package:employee_management_system/core/helpers/format_currency.dart';
import 'package:employee_management_system/features/employee_form/presentation/screens/employee_form_screen.dart';
import 'package:employee_management_system/features/executive_console/presentation/managers/cubits/employee_directory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/employee_model.dart';
import '../../../../../core/theme/app_tokens.dart';

class EmployeeListItemWidget extends StatelessWidget {
  final Employee employee;
  final bool isHighestPaid;

  const EmployeeListItemWidget({
    super.key,
    required this.employee,
    this.isHighestPaid = false,
  });

  void _showActionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        title: Text(
          employee.name,
          style: AppTypography.headlineSm.copyWith(color: AppColors.onSurface),
        ),
        content: Text(
          'What would you like to do with this employee record?',
          style: AppTypography.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<EmployeeDirectoryCubit>().deleteEmployee(
                employee.employeeID,
              );
            },
            child: Text(
              'Delete',
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<EmployeeDirectoryCubit>(),
                    child: EmployeeFormScreen(employee: employee),
                  ),
                ),
              );
            },
            child: Text(
              'Update',
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        splashColor: AppColors.primary.withValues(alpha: 0.12),
        highlightColor: AppColors.primary.withValues(alpha: 0.06),
        onLongPress: () => _showActionsDialog(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _Header(employee: employee, isHighestPaid: isHighestPaid),
              const _SectionDivider(),
              _Footer(employee: employee),
            ],
          ),
        ),
      ),
    );
  }
}

/// Top row: avatar (+ optional highest-paid badge), name, emp ID, department chip.
class _Header extends StatelessWidget {
  final Employee employee;
  final bool isHighestPaid;

  const _Header({required this.employee, required this.isHighestPaid});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Avatar(initials: employee.initials, showBadge: isHighestPaid),
        const SizedBox(width: 14.0),
        Expanded(
          child: _NameAndId(name: employee.name, empId: employee.displayEmpId),
        ),
        _DepartmentChip(label: employee.displayDepartment),
      ],
    );
  }
}

/// Circular avatar with initials, optionally showing a gold "highest paid" badge.
class _Avatar extends StatelessWidget {
  final String initials;
  final bool showBadge;

  const _Avatar({required this.initials, required this.showBadge});

  static const double _size = 48.0;
  static const double _badgeSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Center(
            child: Text(
              initials,
              style: AppTypography.bodyLg.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.workspace_premium,
                size: _badgeSize,
                color: AppColors.primary,
              ),
            ),
          ),
      ],
    );
  }
}

/// Employee name + "EMP ID: ###" line.
class _NameAndId extends StatelessWidget {
  final String name;
  final String empId;

  const _NameAndId({required this.name, required this.empId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 2.0),
        Text(
          _getName(),
          style: AppTypography.headlineSm.copyWith(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'EMP ID: $empId',
          style: AppTypography.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  String _getName() =>
      "${name[0].toUpperCase()}${name.substring(1, name.length)}";
}

/// Small rounded chip showing the department label.
class _DepartmentChip extends StatelessWidget {
  final String label;

  const _DepartmentChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.labelSm.copyWith(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

/// Thin horizontal divider between header and footer rows.
class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Divider(
        color: AppColors.outlineVariant.withValues(alpha: 0.3),
        height: 1.0,
        thickness: 1.0,
      ),
    );
  }
}

/// Bottom row: Manager ID (left) and Salary (right).
class _Footer extends StatelessWidget {
  final Employee employee;

  const _Footer({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _LabeledValue(
          label: 'MANAGER ID',
          value: employee.displayManagerId,
          valueStyle: AppTypography.bodyMd.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        _LabeledValue(
          label: 'SALARY',
          value: formatCurrency(employee.salary),
          crossAxisAlignment: CrossAxisAlignment.end,
          valueStyle: AppTypography.bodyLg.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Small uppercase label above a value — used for Manager ID and Salary.
class _LabeledValue extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle valueStyle;
  final CrossAxisAlignment crossAxisAlignment;

  const _LabeledValue({
    required this.label,
    required this.value,
    required this.valueStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: AppTypography.labelSm.copyWith(
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(value, style: valueStyle),
      ],
    );
  }
}
