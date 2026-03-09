import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../../../shared/widgets/user_avatar.dart';
import '../../auth/providers/user_provider.dart';
import '../providers/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  bool _initialized = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _initControllers() {
    if (_initialized) return;
    final user = ref.read(userNotifierProvider).valueOrNull;
    _firstNameController =
        TextEditingController(text: user?.firstName ?? '');
    _lastNameController =
        TextEditingController(text: user?.lastName ?? '');
    _initialized = true;
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );
    if (image == null) return;

    final success =
        await ref.read(profileActionNotifierProvider.notifier).uploadPicture(image);
    if (success && mounted) {
      showSuccessSnackBar(context, 'Profilna slika ažurirana!');
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref
        .read(profileActionNotifierProvider.notifier)
        .updateProfile(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
        );

    if (success && mounted) {
      showSuccessSnackBar(context, 'Profil uspješno ažuriran!');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _initControllers();

    final user = ref.watch(userNotifierProvider).valueOrNull;
    final actionState = ref.watch(profileActionNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Uredi profil', style: AppTextStyles.heading3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Avatar with edit button
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  UserAvatar(
                    imageUrl: user?.profileImageUrl,
                    firstName: user?.firstName ?? '',
                    lastName: user?.lastName ?? '',
                    radius: 52,
                  ),
                  GestureDetector(
                    onTap: actionState.isLoading
                        ? null
                        : _pickAndUploadImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.onAccent,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // First name
              CustomTextField(
                controller: _firstNameController,
                label: 'Ime',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ime je obavezno.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Last name
              CustomTextField(
                controller: _lastNameController,
                label: 'Prezime',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Prezime je obavezno.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Error
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

              // Save button
              PrimaryButton(
                label: 'Sačuvaj',
                isLoading: actionState.isLoading,
                onPressed: _saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
