import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/utils/image_utils.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_display.dart';
import '../../../shared/widgets/skeletons.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/rating_stars.dart';
import '../../../shared/widgets/review_card.dart';
import '../../auth/providers/user_provider.dart';
import '../../shop/data/review_repository.dart';
import '../../shop/models/review_model.dart';
import '../../shop/models/update_review_request.dart';
import '../providers/staff_reviews_provider.dart';
import '../providers/staff_provider.dart';

class StaffDetailScreen extends ConsumerWidget {
  final int staffId;

  const StaffDetailScreen({super.key, required this.staffId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffDetailProvider(staffId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: staffAsync.whenOrNull(
          data: (staff) => Text(
            '${staff.firstName} ${staff.lastName}',
            style: AppTextStyles.heading3,
          ),
        ),
      ),
      body: staffAsync.when(
        loading: () => const StaffDetailSkeleton(),
        error: (_, _) => ErrorDisplay(
          message: 'Greška pri učitavanju profila.',
          onRetry: () => ref.invalidate(staffDetailProvider(staffId)),
        ),
        data: (staff) {
          final fullUrl = ImageUtils.fullImageUrl(staff.profileImageUrl);
          final initials =
              '${staff.firstName.isNotEmpty ? staff.firstName[0] : ''}${staff.lastName.isNotEmpty ? staff.lastName[0] : ''}'
                  .toUpperCase();

          final typeLabel = staff.staffType == 'Trainer'
              ? 'Trener'
              : staff.staffType == 'Nutritionist'
                  ? 'Nutricionist'
                  : staff.staffType;
          final typeColor = staff.staffType == 'Trainer'
              ? AppColors.accent
              : AppColors.success;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Profile image
              Center(
                child: Hero(
                  tag: 'staff-image-$staffId',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: fullUrl != null
                          ? CachedNetworkImage(
                              imageUrl: fullUrl,
                              fit: BoxFit.cover,
                              placeholder: (_, _) => Container(
                                color: AppColors.inputFill,
                                child: Center(
                                  child: Text(
                                    initials,
                                    style: AppTextStyles.heading1.copyWith(
                                      color: AppColors.textHint,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (_, _, _) => Container(
                                color: AppColors.inputFill,
                                child: Center(
                                  child: Text(
                                    initials,
                                    style: AppTextStyles.heading1.copyWith(
                                      color: AppColors.textHint,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              color: AppColors.inputFill,
                              child: Center(
                                child: Text(
                                  initials,
                                  style: AppTextStyles.heading1.copyWith(
                                    color: AppColors.textHint,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Name
              Center(
                child: Text(
                  '${staff.firstName} ${staff.lastName}',
                  style: AppTextStyles.heading2,
                ),
              ),
              const SizedBox(height: 8),

              // Type badge
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: typeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    typeLabel,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: typeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Info card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (staff.email.isNotEmpty) ...[
                      _InfoRow(
                        icon: Icons.email_outlined,
                        value: staff.email,
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (staff.phone != null && staff.phone!.isNotEmpty) ...[
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        value: staff.phone!,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),

              // Bio
              if (staff.bio != null && staff.bio!.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text('O nama', style: AppTextStyles.heading3),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    staff.bio!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],

              // Reviews section
              _buildReviewsSection(context, ref, staff.id),

              const SizedBox(height: 32),

              // Book button
              PrimaryButton(
                label: 'Zakaži termin',
                onPressed: () =>
                    context.push('/book-appointment/${staff.id}'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReviewsSection(
      BuildContext context, WidgetRef ref, int staffId) {
    final reviewsState = ref.watch(staffReviewsNotifierProvider(staffId));
    final userAsync = ref.watch(userNotifierProvider);
    final currentUserId = userAsync.valueOrNull?.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Divider(color: AppColors.border),
        const SizedBox(height: 16),

        // Reviews header
        Row(
          children: [
            Text('Recenzije', style: AppTextStyles.heading3),
            const Spacer(),
            if (reviewsState.averageRating != null) ...[
              RatingStars(
                rating: reviewsState.averageRating!,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                reviewsState.averageRating!.toStringAsFixed(1),
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),

        // Reviews list
        if (reviewsState.isLoading && reviewsState.reviews.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: AppColors.accent,
                strokeWidth: 2,
              ),
            ),
          )
        else if (reviewsState.reviews.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: EmptyState(
              icon: Icons.reviews_outlined,
              message: 'Nema recenzija za ovo osoblje.',
            ),
          )
        else
          ...reviewsState.reviews.map(
            (review) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ReviewCard(
                userName: review.userFullName,
                rating: review.rating,
                comment: review.comment,
                createdAt: review.createdAt,
                onEdit: currentUserId != null &&
                        review.userId == currentUserId
                    ? () => _showEditReviewSheet(
                        context, ref, staffId, review)
                    : null,
                onDelete: currentUserId != null &&
                        review.userId == currentUserId
                    ? () => _confirmDeleteReview(
                        context, ref, staffId, review.id)
                    : null,
              ),
            ),
          ),

        // Load more
        if (reviewsState.hasMore && reviewsState.reviews.isNotEmpty)
          Center(
            child: TextButton(
              onPressed: () => ref
                  .read(staffReviewsNotifierProvider(staffId).notifier)
                  .loadMore(),
              child: Text(
                'Učitaj više',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showEditReviewSheet(BuildContext context, WidgetRef ref, int staffId,
      ReviewModel review) {
    int selectedRating = review.rating;
    final commentController =
        TextEditingController(text: review.comment ?? '');
    bool isSubmitting = false;
    String? errorMessage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Uredi recenziju', style: AppTextStyles.heading3),
              const SizedBox(height: 16),

              // Stars
              Center(
                child: RatingStars(
                  rating: selectedRating.toDouble(),
                  size: 36,
                  interactive: true,
                  onRatingChanged: (rating) {
                    setSheetState(() => selectedRating = rating);
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Comment
              TextField(
                controller: commentController,
                maxLines: 3,
                style: AppTextStyles.input,
                decoration: InputDecoration(
                  hintText: 'Komentar (opcionalno)',
                  hintStyle: AppTextStyles.inputHint,
                  filled: true,
                  fillColor: AppColors.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // Error message
              if (errorMessage != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    errorMessage!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),

              // Submit
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: selectedRating == 0 || isSubmitting
                      ? null
                      : () async {
                          setSheetState(() => isSubmitting = true);
                          try {
                            final repo = ref.read(reviewRepositoryProvider);
                            await repo.updateReview(
                              review.id,
                              UpdateReviewRequest(
                                rating: selectedRating,
                                comment: commentController.text.isNotEmpty
                                    ? commentController.text
                                    : null,
                              ),
                            );
                            ref.invalidate(
                                staffReviewsNotifierProvider(staffId));
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Recenzija uspješno ažurirana!'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }
                          } on ApiException catch (e) {
                            setSheetState(() {
                              isSubmitting = false;
                              errorMessage = e.firstError;
                            });
                          } catch (_) {
                            setSheetState(() {
                              isSubmitting = false;
                              errorMessage =
                                  'Neočekivana greška. Pokušajte ponovo.';
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.onAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.onAccent,
                          ),
                        )
                      : Text('Sačuvaj', style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDeleteReview(
      BuildContext context, WidgetRef ref, int staffId, int reviewId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Obriši recenziju?',
          style: AppTextStyles.heading3,
        ),
        content: Text(
          'Da li ste sigurni da želite obrisati ovu recenziju?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Ne',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              try {
                final repo = ref.read(reviewRepositoryProvider);
                await repo.deleteReview(reviewId);
                ref.invalidate(staffReviewsNotifierProvider(staffId));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Recenzija uspješno obrisana.'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              } on ApiException catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.firstError),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              } catch (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Neočekivana greška. Pokušajte ponovo.'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            child: Text(
              'Da, obriši',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String value;

  const _InfoRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textHint, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
