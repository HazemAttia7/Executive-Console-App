import 'package:employee_management_system/core/theme/app_tokens.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required String message,
  required IconData icon,
  bool isError = false,
  required BuildContext context,
}) {
  final messenger = ScaffoldMessenger.of(context);

  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppSpacing.containerMargin),
        backgroundColor: isError
            ? AppColors.errorContainer
            : AppColors.primaryContainer,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        content: Row(
          children: [
            Icon(
              icon,
              color: isError
                  ? AppColors.onErrorContainer
                  : AppColors.onPrimaryContainer,
            ),
            const SizedBox(width: AppSpacing.elementPadding),
            Expanded(
              child: Text(
                message,
                style: AppTypography.bodyMd.copyWith(
                  color: isError
                      ? AppColors.onErrorContainer
                      : AppColors.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
}
