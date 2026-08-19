import 'package:employee_management_system/core/theme/app_tokens.dart';
import 'package:employee_management_system/features/employee_form/presentation/screens/widgets/employee_form_screen_body.dart';
import 'package:employee_management_system/features/executive_console/data/models/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeFormScreen extends StatelessWidget {
  final Employee? employee;

  const EmployeeFormScreen({super.key, this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.onSurface),
        title: Text(
          employee != null ? 'Update Employee' : 'Add Employee',
          style: AppTypography.headlineSm,
        ),
      ),
      body: EmployeeFormScreenBody(employee: employee),
    );
  }
}
