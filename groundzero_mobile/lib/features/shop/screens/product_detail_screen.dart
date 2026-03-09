import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/utils/image_utils.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_display.dart';
import '../../../shared/widgets/skeletons.dart';
import '../../../shared/widgets/rating_stars.dart';
import '../../../shared/widgets/review_card.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../../auth/providers/user_provider.dart';
import '../../orders/providers/cart_provider.dart';
import '../data/review_repository.dart';
import '../models/create_review_request.dart';
import '../models/update_review_request.dart';
import '../providers/product_detail_provider.dart';
import '../providers/product_reviews_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));
    final reviewsState =
        ref.watch(productReviewsNotifierProvider(productId));
    final currentUserId = ref.watch(userNotifierProvider).valueOrNull?.id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: productAsync.whenOrNull(
          data: (product) => Text(
            product.name,
            style: AppTextStyles.heading3,
          ),
        ),
      ),
      bottomNavigationBar: productAsync.whenOrNull(
        data: (product) => product.stockQuantity > 0
            ? Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.surfaceHigh,
                  boxShadow: AppShadows.elevated,
                ),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .addItem(product);
                        showSuccessSnackBar(context, '${product.name} dodano u korpu.');
                      },
                      icon: const Icon(Icons.add_shopping_cart_rounded),
                      label: Text(
                        'Dodaj u korpu',
                        style: AppTextStyles.button,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.onAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: productAsync.when(
        loading: () => const ProductDetailSkeleton(),
        error: (error, _) => ErrorDisplay(
          message: 'Greška pri učitavanju proizvoda.',
          onRetry: () => ref.invalidate(productDetailProvider(productId)),
        ),
        data: (product) {
          final fullImageUrl = ImageUtils.fullImageUrl(product.imageUrl);

          return ListView(
            children: [
              // Product image
              Hero(
                tag: 'product-image-$productId',
                child: AspectRatio(
                  aspectRatio: 1,
                  child: fullImageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: fullImageUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, _) => Container(
                            color: AppColors.inputFill,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.accent,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (_, _, _) => Container(
                            color: AppColors.inputFill,
                            child: const Icon(
                              Icons.broken_image_outlined,
                              color: AppColors.textHint,
                              size: 64,
                            ),
                          ),
                        )
                      : Container(
                          color: AppColors.inputFill,
                          child: const Center(
                            child: Icon(
                              Icons.fitness_center,
                              color: AppColors.textHint,
                              size: 64,
                            ),
                          ),
                        ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product.categoryName,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Name
                    Text(product.name, style: AppTextStyles.heading2),
                    const SizedBox(height: 8),

                    // Price
                    Text(
                      '${product.price.toStringAsFixed(2)} KM',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Stock
                    Row(
                      children: [
                        Icon(
                          product.stockQuantity > 0
                              ? Icons.check_circle_outline_rounded
                              : Icons.cancel_outlined,
                          size: 16,
                          color: product.stockQuantity > 0
                              ? AppColors.success
                              : AppColors.error,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          product.stockQuantity > 0
                              ? 'Na stanju (${product.stockQuantity})'
                              : 'Nema na stanju',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: product.stockQuantity > 0
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description
                    if (product.description != null &&
                        product.description!.isNotEmpty) ...[
                      Text(
                        product.description!,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Divider
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
                            reviewsState.averageRating!
                                .toStringAsFixed(1),
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Add review button
                    TextButton.icon(
                      onPressed: () =>
                          _showReviewSheet(context, ref),
                      icon: const Icon(Icons.rate_review_outlined,
                          size: 18),
                      label: const Text('Ostavi recenziju'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.accent,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Reviews list
                    if (reviewsState.isLoading &&
                        reviewsState.reviews.isEmpty)
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
                          message: 'Nema recenzija za ovaj proizvod.',
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
                                    context, ref, review)
                                : null,
                            onDelete: currentUserId != null &&
                                    review.userId == currentUserId
                                ? () => _confirmDeleteReview(
                                    context, ref, review.id)
                                : null,
                          ),
                        ),
                      ),

                    // Load more reviews
                    if (reviewsState.hasMore &&
                        reviewsState.reviews.isNotEmpty)
                      Center(
                        child: TextButton(
                          onPressed: () => ref
                              .read(productReviewsNotifierProvider(
                                      productId)
                                  .notifier)
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showReviewSheet(BuildContext context, WidgetRef ref) {
    int selectedRating = 0;
    final commentController = TextEditingController();
    bool isSubmitting = false;
    String? errorMessage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceHigh,
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
              Text('Ostavi recenziju', style: AppTextStyles.heading3),
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
                            final repo =
                                ref.read(reviewRepositoryProvider);
                            await repo.createReview(
                              CreateReviewRequest(
                                rating: selectedRating,
                                comment:
                                    commentController.text.isNotEmpty
                                        ? commentController.text
                                        : null,
                                reviewType: 0, // Product
                                productId: productId,
                              ),
                            );
                            ref.invalidate(
                                productReviewsNotifierProvider(
                                    productId));
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              showSuccessSnackBar(context, 'Recenzija uspješno dodana!');
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
                      : Text('Pošalji', style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditReviewSheet(
      BuildContext context, WidgetRef ref, dynamic review) {
    int selectedRating = review.rating;
    final commentController =
        TextEditingController(text: review.comment ?? '');
    bool isSubmitting = false;
    String? errorMessage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceHigh,
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
                                productReviewsNotifierProvider(productId));
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              showSuccessSnackBar(context, 'Recenzija uspješno ažurirana!');
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
      BuildContext context, WidgetRef ref, int reviewId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceHigh,
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
                ref.invalidate(
                    productReviewsNotifierProvider(productId));
                if (context.mounted) {
                  showSuccessSnackBar(context, 'Recenzija uspješno obrisana.');
                }
              } on ApiException catch (e) {
                if (context.mounted) {
                  showErrorSnackBar(context, e.firstError);
                }
              } catch (_) {
                if (context.mounted) {
                  showErrorSnackBar(context, 'Neočekivana greška. Pokušajte ponovo.');
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
