import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../providers/profile_provider.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref
        .read(profileActionNotifierProvider.notifier)
        .changePassword(
          _currentPasswordController.text,
          _newPasswordController.text,
        );

    if (success && mounted) {
      showSuccessSnackBar(context, 'Lozinka uspješno promijenjena!');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(profileActionNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Promijeni lozinku', style: AppTextStyles.heading3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),

              CustomTextField(
                controller: _currentPasswordController,
                label: 'Trenutna lozinka',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Trenutna lozinka je obavezna.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: _newPasswordController,
                label: 'Nova lozinka',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nova lozinka je obavezna.';
                  }
                  if (value.trim().length < 6) {
                    return 'Nova lozinka mora imati najmanje 6 karaktera.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: _confirmPasswordController,
                label: 'Potvrdi novu lozinku',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Potvrda lozinke je obavezna.';
                  }
                  if (value.trim() != _newPasswordController.text.trim()) {
                    return 'Lozinke se ne podudaraju.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              if (actionState.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    actionState.error!,
                    style: AppTextStyles.error,
                    textAlign: TextAlign.center,
                  ),
                ),

              const SizedBox(height: 16),

              PrimaryButton(
                label: 'Promijeni lozinku',
                isLoading: actionState.isLoading,
                onPressed: _changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
