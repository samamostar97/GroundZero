import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/pagination_controls.dart';
import '../../../shared/widgets/search_input.dart';
import '../providers/gym_visits_provider.dart';

class GymVisitsScreen extends ConsumerWidget {
  const GymVisitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gymVisitsNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Historija posjeta',
            style: GoogleFonts.barlowCondensed(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pregled svih posjeta teretani',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),

          // Search
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SearchInput(
                hint: 'Pretraži posjete...',
                onChanged: (value) {
                  ref
                      .read(gymVisitsNotifierProvider.notifier)
                      .setSearch(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Table
          Expanded(
            child: _buildContent(context, ref, state),
          ),

          // Pagination
          if (!state.isLoading && state.error == null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: PaginationControls(
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                totalCount: state.totalCount,
                onPrevious: () {
                  ref
                      .read(gymVisitsNotifierProvider.notifier)
                      .loadPage(state.currentPage - 1);
                },
                onNext: () {
                  ref
                      .read(gymVisitsNotifierProvider.notifier)
                      .loadPage(state.currentPage + 1);
                },
              ),
            ),
        ],
      ),
    );
  }

  int? _sortColumnIndex(String? sortBy) {
    return switch (sortBy) {
      'id' => 0,
      'userFullName' => 1,
      'checkInAt' => 2,
      'durationMinutes' => 4,
      'xpEarned' => 5,
      _ => null,
    };
  }

  Widget _buildContent(
      BuildContext context, WidgetRef ref, GymVisitsState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      );
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 40, color: AppColors.error),
            const SizedBox(height: 12),
            Text(
              state.error!,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(gymVisitsNotifierProvider.notifier).refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (state.visits.isEmpty) {
      return Center(
        child: Text(
          'Nema posjeta.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textHint,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: DataTable(
              headingRowHeight: 48,
              dataRowMinHeight: 52,
              dataRowMaxHeight: 52,
              columnSpacing: 24,
              horizontalMargin: 20,
              sortColumnIndex: _sortColumnIndex(state.sortBy),
              sortAscending: !state.sortDescending,
              columns: [
                DataColumn(label: const Text('ID'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('id')),
                DataColumn(label: const Text('Korisnik'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('userFullName')),
                DataColumn(label: const Text('Prijava'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('checkInAt')),
                const DataColumn(label: Text('Odjava')),
                DataColumn(label: const Text('Trajanje'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('durationMinutes')),
                DataColumn(label: const Text('XP'), onSort: (_, __) => ref.read(gymVisitsNotifierProvider.notifier).setSort('xpEarned')),
              ],
              rows: state.visits.map((visit) {
                return DataRow(
                  cells: [
                    DataCell(Text('#${visit.id}')),
                    DataCell(Text(visit.userFullName)),
                    DataCell(
                      Text(DateFormat('dd.MM.yyyy. HH:mm')
                          .format(visit.checkInAt)),
                    ),
                    DataCell(
                      visit.checkOutAt != null
                          ? Text(DateFormat('dd.MM.yyyy. HH:mm')
                              .format(visit.checkOutAt!))
                          : Text('—'),
                    ),
                    DataCell(
                      visit.durationMinutes != null
                          ? Text('${visit.durationMinutes} min')
                          : Text('—'),
                    ),
                    DataCell(Text('${visit.xpEarned}')),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
