import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/pagination_controls.dart';
import '../../../shared/widgets/search_input.dart';
import '../providers/memberships_provider.dart';

const _statusLabels = {
  'Expired': 'Istekla',
  'Cancelled': 'Otkazana',
};

const _statusColors = {
  'Expired': AppColors.warning,
  'Cancelled': AppColors.error,
};

class MembershipsScreen extends ConsumerWidget {
  const MembershipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(membershipsNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Historija članarina',
            style: GoogleFonts.barlowCondensed(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pregled isteklih i otkazanih članarina',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),

          // Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Status filter
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    value: state.statusFilter,
                    dropdownColor: AppColors.surfaceHigh,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.textHint, size: 20),
                    items: [
                      DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Svi statusi'),
                      ),
                      ..._statusLabels.entries.map(
                        (e) => DropdownMenuItem<String?>(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      ),
                    ],
                    onChanged: (v) {
                      ref
                          .read(membershipsNotifierProvider.notifier)
                          .setStatusFilter(v);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SearchInput(
                hint: 'Pretraži historiju članarina...',
                onChanged: (value) {
                  ref
                      .read(membershipsNotifierProvider.notifier)
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
                      .read(membershipsNotifierProvider.notifier)
                      .loadPage(state.currentPage - 1);
                },
                onNext: () {
                  ref
                      .read(membershipsNotifierProvider.notifier)
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
      'planName' => 2,
      'planPrice' => 3,
      'startDate' => 4,
      'endDate' => 5,
      _ => null,
    };
  }

  Widget _buildContent(
      BuildContext context, WidgetRef ref, MembershipsState state) {
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
                  ref.read(membershipsNotifierProvider.notifier).refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (state.memberships.isEmpty) {
      return Center(
        child: Text(
          'Nema članarina u historiji.',
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
                DataColumn(label: const Text('ID'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('id')),
                DataColumn(label: const Text('Korisnik'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('userFullName')),
                DataColumn(label: const Text('Plan'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('planName')),
                DataColumn(label: const Text('Cijena'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('planPrice')),
                DataColumn(label: const Text('Početak'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('startDate')),
                DataColumn(label: const Text('Kraj'), onSort: (_, __) => ref.read(membershipsNotifierProvider.notifier).setSort('endDate')),
                const DataColumn(label: Text('Status')),
              ],
              rows: state.memberships.map((m) {
                final statusLabel = _statusLabels[m.status] ?? m.status;
                final statusColor =
                    _statusColors[m.status] ?? AppColors.textHint;

                return DataRow(
                  cells: [
                    DataCell(Text('#${m.id}')),
                    DataCell(Text(m.userFullName)),
                    DataCell(Text(m.planName)),
                    DataCell(
                        Text('${m.planPrice.toStringAsFixed(2)} KM')),
                    DataCell(
                      Text(DateFormat('dd.MM.yyyy.').format(m.startDate)),
                    ),
                    DataCell(
                      Text(DateFormat('dd.MM.yyyy.').format(m.endDate)),
                    ),
                    DataCell(_StatusBadge(
                      label: statusLabel,
                      color: statusColor,
                    )),
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

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
