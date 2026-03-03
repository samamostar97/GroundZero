import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/providers/user_provider.dart';
import '../data/profile_repository.dart';
import '../models/update_profile_request.dart';

class ProfileActionState {
  final bool isLoading;
  final String? error;
  final bool success;

  const ProfileActionState({
    this.isLoading = false,
    this.error,
    this.success = false,
  });
}

final profileActionNotifierProvider =
    NotifierProvider<ProfileActionNotifier, ProfileActionState>(
  ProfileActionNotifier.new,
);

class ProfileActionNotifier extends Notifier<ProfileActionState> {
  @override
  ProfileActionState build() => const ProfileActionState();

  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
  }) async {
    state = const ProfileActionState(isLoading: true);

    try {
      final repo = ref.read(profileRepositoryProvider);
      await repo.updateProfile(
        UpdateProfileRequest(firstName: firstName, lastName: lastName),
      );
      ref.invalidate(userNotifierProvider);
      state = const ProfileActionState(success: true);
      return true;
    } catch (e) {
      state = ProfileActionState(error: e.toString());
      return false;
    }
  }

  Future<bool> uploadPicture(XFile image) async {
    state = const ProfileActionState(isLoading: true);

    try {
      final repo = ref.read(profileRepositoryProvider);
      await repo.uploadProfilePicture(image);
      ref.invalidate(userNotifierProvider);
      state = const ProfileActionState(success: true);
      return true;
    } catch (e) {
      state = ProfileActionState(error: e.toString());
      return false;
    }
  }

  void reset() => state = const ProfileActionState();
}
