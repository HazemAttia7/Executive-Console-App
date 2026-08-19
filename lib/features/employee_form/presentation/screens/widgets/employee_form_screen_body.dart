import 'package:employee_management_system/core/helpers/app_validators.dart';
import 'package:employee_management_system/core/theme/app_tokens.dart';
import 'package:employee_management_system/core/widgets/show_snack_bar.dart';
import 'package:employee_management_system/features/executive_console/data/models/employee_model.dart';
import 'package:employee_management_system/features/executive_console/presentation/managers/cubits/employee_directory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeFormScreenBody extends StatefulWidget {
  final Employee? employee;

  const EmployeeFormScreenBody({super.key, this.employee});

  @override
  State<EmployeeFormScreenBody> createState() => _EmployeeFormScreenBodyState();
}

class _EmployeeFormScreenBodyState extends State<EmployeeFormScreenBody> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _managerIdController;
  late final TextEditingController _salaryController;

  bool _isSubmitting = false;

  bool get isUpdate => widget.employee != null;

  @override
  void initState() {
    super.initState();

    final employee = widget.employee;

    _nameController = TextEditingController(text: employee?.name ?? '');

    _salaryController = TextEditingController(
      text: employee?.salary.toString() ?? '',
    );

    _managerIdController = TextEditingController(
      text: employee?.managerID?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _salaryController.dispose();
    _managerIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isUpdate
                  ? 'Update employee information'
                  : 'Enter employee information',
              style: AppTypography.bodyLg,
            ),

            const SizedBox(height: AppSpacing.sectionPadding),

            _buildTextField(
              controller: _nameController,
              label: 'Name',
              hint: 'Enter employee name',
              validator: AppValidators.name,
            ),

            const SizedBox(height: AppSpacing.stackGap),

            _buildTextField(
              controller: _managerIdController,
              label: 'Manager ID',
              hint: 'Enter manager ID',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: false,
              ),
            ),

            const SizedBox(height: AppSpacing.stackGap),

            _buildTextField(
              controller: _salaryController,
              label: 'Salary',
              hint: 'Enter employee salary',
              validator: (value) => AppValidators.required(value, 'Salary'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: AppSpacing.sectionPadding),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  disabledBackgroundColor: AppColors.primary.withValues(
                    alpha: 0.5,
                  ),
                  disabledForegroundColor: AppColors.onPrimary.withValues(
                    alpha: 0.7,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.onPrimary,
                        ),
                      )
                    : Text(
                        isUpdate ? 'Update' : 'Add',
                        style: AppTypography.bodyLg.copyWith(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    final isRequired = validator != null;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: AppTypography.bodyLg,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: AppTypography.bodyLg.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: AppTypography.bodyLg.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        hintText: hint,
        hintStyle: AppTypography.bodyMd.copyWith(
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: AppColors.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      validator: validator,
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final employee = Employee(
      employeeID: widget.employee?.employeeID ?? 0,
      name: _nameController.text.trim(),
      salary: double.parse(_salaryController.text),
      managerID: int.tryParse(_managerIdController.text.trim()),
    );

    setState(() {
      _isSubmitting = true;
    });

    final cubit = context.read<EmployeeDirectoryCubit>();

    final bool success;

    if (isUpdate) {
      success = await cubit.updateEmployee(
        widget.employee!.employeeID,
        employee,
      );
    } else {
      success = await cubit.createEmployee(employee);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    if (!success) {
      showSnackBar(
        message: 'Unable to ${isUpdate ? 'update' : 'add'} employee.',
        icon: Icons.error_outline_rounded,
        isError: true,
        context: context,
      );

      return;
    }

    showSnackBar(
      message: isUpdate
          ? 'Employee updated successfully.'
          : 'Employee added successfully.',
      icon: Icons.check_circle_outline_rounded,
      context: context,
    );

    Navigator.pop(context, true);
  }
}
