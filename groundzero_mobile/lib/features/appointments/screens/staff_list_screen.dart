import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/category_chip.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/staff_card.dart';
import '../providers/staff_provider.dart';

class StaffListScreen extends ConsumerStatefulWidget {
  const StaffListScreen({super.key});

  @override
  ConsumerState<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends ConsumerState<StaffListScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(staffListNotifierProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(staffListNotifierProvider.notifier).setSearch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final staffState = ref.watch(staffListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Osoblje', style: AppTextStyles.heading3),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: AppTextStyles.input,
              decoration: InputDecoration(
                hintText: 'Pretraži osoblje...',
                hintStyle: AppTextStyles.inputHint,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.textHint,
                ),
                filled: true,
                fillColor: AppColors.inputFill,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Type filter chips
          SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                CategoryChip(
                  label: 'Svi',
                  isSelected: staffState.staffType == null,
                  onTap: () => ref
                      .read(staffListNotifierProvider.notifier)
                      .setStaffType(null),
                ),
                const SizedBox(width: 8),
                CategoryChip(
                  label: 'Treneri',
                  isSelected: staffState.staffType == 'Trainer',
                  onTap: () => ref
                      .read(staffListNotifierProvider.notifier)
                      .setStaffType('Trainer'),
                ),
                const SizedBox(width: 8),
                CategoryChip(
                  label: 'Nutricionisti',
                  isSelected: staffState.staffType == 'Nutritionist',
                  onTap: () => ref
                      .read(staffListNotifierProvider.notifier)
                      .setStaffType('Nutritionist'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Staff grid
          Expanded(
            child: RefreshIndicator(
              color: AppColors.accent,
              onRefresh: () async {
                ref.read(staffListNotifierProvider.notifier).loadInitial();
              },
              child: _buildStaffGrid(staffState),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffGrid(StaffListState state) {
    if (state.isLoading && state.staff.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      );
    }

    if (state.staff.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 100),
          EmptyState(
            icon: Icons.people_outline_rounded,
            message: 'Nema osoblja za prikaz.',
          ),
        ],
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: state.staff.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.staff.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(
                color: AppColors.accent,
                strokeWidth: 2,
              ),
            ),
          );
        }

        final member = state.staff[index];
        return StaffCard(
          firstName: member.firstName,
          lastName: member.lastName,
          staffType: member.staffType,
          profileImageUrl: member.profileImageUrl,
          onTap: () => context.push('/staff/${member.id}'),
        );
      },
    );
  }
}
