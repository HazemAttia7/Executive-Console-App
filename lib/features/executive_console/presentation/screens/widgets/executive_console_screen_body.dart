import 'package:employee_management_system/core/theme/app_tokens.dart';
import 'package:employee_management_system/features/executive_console/presentation/managers/cubits/employee_directory_cubit.dart';
import 'package:employee_management_system/features/executive_console/presentation/screens/widgets/analytics_overview_section.dart';
import 'package:employee_management_system/features/executive_console/presentation/screens/widgets/employee_directory_section.dart';
import 'package:employee_management_system/features/executive_console/presentation/screens/widgets/highest_paid_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExecutiveConsoleScreenBody extends StatelessWidget {
  const ExecutiveConsoleScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeDirectoryCubit, EmployeeDirectoryState>(
      builder: (context, state) {
        // Full-screen loading only on first load — not on pull-to-refresh,
        // since RefreshIndicator shows its own spinner for that case.
        if (state is EmployeeDirectoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is EmployeeDirectoryError) {
          return _ErrorView(
            message: state.message,
            onRetry: () => context.read<EmployeeDirectoryCubit>().retry(),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surfaceContainer,
          onRefresh: () => context.read<EmployeeDirectoryCubit>().retry(),
          child: SingleChildScrollView(
            // Required so the scroll gesture works even when content is
            // shorter than the screen (otherwise drag-to-refresh won't trigger).
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.containerMargin,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnalyticsSection(state),
                const SizedBox(height: AppSpacing.sectionPadding + 16),
                _buildHighestPaidSection(state),
                const SizedBox(height: AppSpacing.sectionPadding - 16),
                const EmployeeDirectorySection(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnalyticsSection(EmployeeDirectoryState state) {
    if (state is EmployeeDirectoryLoaded && state.highestPaid.isNotEmpty) {
      return AnalyticsOverviewSection(
        avgSalary: state.avgSalary,
        highestPaidSalary: state.highestPaid.first.salary,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildHighestPaidSection(EmployeeDirectoryState state) {
    if (state is EmployeeDirectoryLoaded && state.highestPaid.isNotEmpty) {
      return HighestPaidListSection(employees: state.highestPaid);
    }
    return const SizedBox.shrink();
  }
}

/// Full-screen error state with a retry button — shown when the initial
/// load fails (e.g. phone and PC aren't on the same Wi-Fi network).
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              color: AppColors.error,
              size: 40.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
