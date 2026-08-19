import 'package:employee_management_system/features/executive_console/presentation/screens/widgets/executive_console_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../managers/cubits/employee_directory_cubit.dart';
import '../../../../core/di/di_setup.dart';
import '../../../../core/theme/app_tokens.dart';
import 'widgets/executive_app_bar.dart';

class ExecutiveConsoleScreen extends StatelessWidget {
  const ExecutiveConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmployeeDirectoryCubit>()..loadData(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const ExecutiveAppBar(),
        body: ExecutiveConsoleScreenBody(),
      ),
    );
  }
}
