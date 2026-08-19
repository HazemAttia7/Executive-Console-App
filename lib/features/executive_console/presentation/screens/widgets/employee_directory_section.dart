import 'package:employee_management_system/features/executive_console/data/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../managers/cubits/employee_directory_cubit.dart';
import '../../../../../core/theme/app_tokens.dart';
import 'employee_list_item_widget.dart';

class EmployeeDirectorySection extends StatefulWidget {
  const EmployeeDirectorySection({super.key});

  @override
  State<EmployeeDirectorySection> createState() =>
      _EmployeeDirectorySectionState();
}

class _EmployeeDirectorySectionState extends State<EmployeeDirectorySection> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    final value = _searchController.text.trim();

    if (value.isEmpty) {
      context.read<EmployeeDirectoryCubit>().loadData();
      return;
    }

    context.read<EmployeeDirectoryCubit>().searchEmployeeById(value);
  }

  void _clearSearch() {
    _searchController.clear();

    context.read<EmployeeDirectoryCubit>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Employee Directory',
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

        _SearchField(
          controller: _searchController,
          onSearch: _search,
          onClear: _clearSearch,
        ),

        const SizedBox(height: AppSpacing.stackGap),
        BlocBuilder<EmployeeDirectoryCubit, EmployeeDirectoryState>(
          buildWhen: (previous, current) =>
              current is EmployeeDirectoryLoading ||
              current is EmployeeDirectoryLoaded ||
              current is EmployeeDirectorySearching ||
              current is EmployeeDirectoryError,
          builder: (context, state) {
            if (state is EmployeeDirectoryLoading ||
                state is EmployeeDirectoryInitial) {
              return const _LoadingIndicator();
            }

            if (state is EmployeeDirectoryError) {
              return _ErrorBanner(
                message: state.message,
                onRetry: () {
                  context.read<EmployeeDirectoryCubit>().retry();
                },
              );
            }

            if (state is EmployeeDirectorySearching) {
              return _EmployeeList(
                employees: state.employees,
                isSearching: true,
              );
            }

            if (state is EmployeeDirectoryLoaded) {
              return _EmployeeList(employees: state.employees);
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _EmployeeList extends StatelessWidget {
  final List<Employee> employees;
  final bool isSearching;

  const _EmployeeList({required this.employees, this.isSearching = false});

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) {
      return const _EmptyState();
    }

    return Stack(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: employees.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: AppSpacing.stackGap);
          },
          itemBuilder: (context, index) {
            return EmployeeListItemWidget(employee: employees[index]);
          },
        ),

        if (isSearching)
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SearchField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);

    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller.text.isNotEmpty;

    return TextField(
      controller: widget.controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => widget.onSearch(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        hintText: 'Search by Employee ID',

        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.onSurfaceVariant,
        ),

        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasText)
              IconButton(
                onPressed: widget.onClear,
                icon: const Icon(Icons.clear_rounded),
                color: AppColors.onSurfaceVariant,
              ),

            IconButton(
              onPressed: widget.onSearch,
              icon: const Icon(Icons.arrow_forward_rounded),
              color: AppColors.primary,
            ),
          ],
        ),

        filled: true,
        fillColor: AppColors.surfaceContainer,

        hintStyle: AppTypography.bodyMd.copyWith(
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48.0),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorBanner({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.stackGap),
      decoration: BoxDecoration(
        color: AppColors.errorContainer.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.wifi_off_rounded, color: AppColors.error, size: 32.0),

          const SizedBox(height: 12.0),

          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onErrorContainer,
            ),
          ),

          const SizedBox(height: 16.0),

          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18.0),
            label: const Text('Retry'),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Center(
        child: Text(
          'No employees found.',
          style: AppTypography.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
