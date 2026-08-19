import 'package:employee_management_system/features/executive_console/presentation/screens/widgets/add_new_employee_button.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_tokens.dart';

class ExecutiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExecutiveAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.containerMargin,
        ),
        color: AppColors.background,
        child: Row(
          children: [
            const Icon(
              Icons.shield_outlined,
              color: AppColors.primary,
              size: 26.0,
            ),
            const SizedBox(width: 10.0),
            Text(
              'Executive Console',
              style: AppTypography.headlineSm.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            AddNewEmployeeButton(),
          ],
        ),
      ),
    );
  }
}
