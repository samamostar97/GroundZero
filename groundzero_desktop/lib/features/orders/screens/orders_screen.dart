import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/pagination_controls.dart';
import '../../../shared/widgets/pill_toggle.dart';
import '../../../shared/widgets/search_input.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../models/order_model.dart';
import '../providers/orders_provider.dart';

const _statusLabels = {
  0: 'Na čekanju',
  1: 'Potvrđeno',
  2: 'Poslano',
  3: 'Dostavljeno',
  4: 'Otkazano',
};

const _statusColors = {
  0: AppColors.warning,
  1: AppColors.accent,
  2: Color(0xFF64B5F6),
  3: AppColors.success,
  4: AppColors.error,
};

// Active = Pending, Confirmed, Shipped
const _activeStatuses = {0, 1, 2};
// History = Delivered, Cancelled
const _historyStatuses = {3, 4};

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  int _viewIndex = 0; // 0 = Aktivne, 1 = Historija

  void _onViewChanged(int index) {
    setState(() => _viewIndex = index);
    final notifier = ref.read(ordersNotifierProvider.notifier);
    notifier.switchView(
      excludeStatuses: index == 0 ? _historyStatuses : _activeStatuses,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ordersNotifierProvider);
    final isHistory = _viewIndex == 1;

    // Filter dropdown items based on view
    final filterItems = <int?, String>{null: 'Svi statusi'};
    if (!isHistory) {
      filterItems.addAll({0: 'Na čekanju', 1: 'Potvrđeno', 2: 'Poslano'});
    } else {
      filterItems.addAll({3: 'Dostavljeno', 4: 'Otkazano'});
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Narudžbe',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isHistory
                        ? 'Pregled dostavljenih i otkazanih narudžbi'
                        : 'Pregled i upravljanje narudžbama',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              PillToggle(
                labels: const ['Aktivne', 'Historija'],
                selectedIndex: _viewIndex,
                onChanged: _onViewChanged,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _FilterDropdown(
                value: state.statusFilter,
                items: filterItems,
                onChanged: (value) {
                  ref
                      .read(ordersNotifierProvider.notifier)
                      .setStatusFilter(value);
                },
              ),
              const SizedBox(width: 12),
              SearchInput(
                hint: 'Pretraži narudžbe...',
                onChanged: (value) {
                  ref
                      .read(ordersNotifierProvider.notifier)
                      .setSearch(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Table
          Expanded(
            child: _buildContent(context, ref, state, isHistory),
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
                      .read(ordersNotifierProvider.notifier)
                      .loadPage(state.currentPage - 1);
                },
                onNext: () {
                  ref
                      .read(ordersNotifierProvider.notifier)
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
      'totalAmount' => 2,
      'status' => 3,
      'createdAt' => 4,
      _ => null,
    };
  }

  Widget _buildContent(
      BuildContext context, WidgetRef ref, OrdersState state, bool isHistory) {
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
                  ref.read(ordersNotifierProvider.notifier).refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (state.orders.isEmpty) {
      return Center(
        child: Text(
          'Nema narudžbi.',
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
                DataColumn(label: const Text('ID'), onSort: (_, __) => ref.read(ordersNotifierProvider.notifier).setSort('id')),
                DataColumn(label: const Text('Korisnik'), onSort: (_, __) => ref.read(ordersNotifierProvider.notifier).setSort('userFullName')),
                DataColumn(label: const Text('Iznos (KM)'), onSort: (_, __) => ref.read(ordersNotifierProvider.notifier).setSort('totalAmount')),
                DataColumn(label: const Text('Status'), onSort: (_, __) => ref.read(ordersNotifierProvider.notifier).setSort('status')),
                DataColumn(label: const Text('Datum'), onSort: (_, __) => ref.read(ordersNotifierProvider.notifier).setSort('createdAt')),
                if (!isHistory) const DataColumn(label: Text('Akcije')),
              ],
              rows: state.orders.map((order) {
                return DataRow(
                  cells: [
                    DataCell(Text('#${order.id}')),
                    DataCell(Text(order.userFullName)),
                    DataCell(Text(order.totalAmount.toStringAsFixed(2))),
                    DataCell(_StatusBadge(
                      label: _statusLabels[order.status] ?? 'Nepoznato',
                      color: _statusColors[order.status] ?? AppColors.textHint,
                    )),
                    DataCell(
                      Text(DateFormat('dd.MM.yyyy.').format(order.createdAt)),
                    ),
                    if (!isHistory)
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _ActionButton(
                              icon: Icons.visibility_outlined,
                              color: AppColors.accent,
                              tooltip: 'Detalji',
                              onTap: () =>
                                  _showOrderDetail(context, order),
                            ),
                            const SizedBox(width: 4),
                            PopupMenuButton<int>(
                              tooltip: 'Promijeni status',
                              icon: Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: AppColors.textSecondary,
                              ),
                              color: AppColors.surfaceHigh,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    color: AppColors.border, width: 0.5),
                              ),
                              onSelected: (newStatus) async {
                                final error = await ref
                                    .read(ordersNotifierProvider.notifier)
                                    .updateStatus(order.id, newStatus);
                                if (context.mounted) {
                                  if (error != null) {
                                    showErrorSnackBar(context, error);
                                  } else {
                                    showSuccessSnackBar(
                                        context, 'Status narudžbe ažuriran.');
                                  }
                                }
                              },
                              itemBuilder: (context) => _statusLabels.entries
                                  .where((e) => e.key != order.status)
                                  .map(
                                    (e) => PopupMenuItem<int>(
                                      value: e.key,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: _statusColors[e.key],
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            e.value,
                                            style: GoogleFonts.inter(
                                              fontSize: 13,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showOrderDetail(BuildContext context, OrderModel order) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.border, width: 0.5),
        ),
        child: Container(
          width: 520,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Narudžba #${order.id}',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppColors.textHint),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _detailRow('Korisnik', order.userFullName),
              _detailRow('Datum',
                  DateFormat('dd.MM.yyyy. HH:mm').format(order.createdAt)),
              _detailRow('Status',
                  _statusLabels[order.status] ?? 'Nepoznato'),
              _detailRow(
                  'Ukupno', '${order.totalAmount.toStringAsFixed(2)} KM'),
              const SizedBox(height: 16),
              Text(
                'Stavke narudžbe',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border, width: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DataTable(
                  headingRowHeight: 40,
                  dataRowMinHeight: 40,
                  dataRowMaxHeight: 40,
                  columnSpacing: 16,
                  horizontalMargin: 12,
                  columns: const [
                    DataColumn(label: Text('Proizvod')),
                    DataColumn(label: Text('Cijena'), numeric: true),
                    DataColumn(label: Text('Kol.'), numeric: true),
                    DataColumn(label: Text('Ukupno'), numeric: true),
                  ],
                  rows: order.items
                      .map(
                        (item) => DataRow(cells: [
                          DataCell(Text(item.productName)),
                          DataCell(
                              Text('${item.unitPrice.toStringAsFixed(2)} KM')),
                          DataCell(Text('${item.quantity}')),
                          DataCell(
                              Text('${item.subtotal.toStringAsFixed(2)} KM')),
                        ]),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Zatvori',
                    style: GoogleFonts.inter(color: AppColors.textSecondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textHint,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
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

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(widget.icon, size: 18, color: widget.color),
          ),
        ),
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final int? value;
  final Map<int?, String> items;
  final ValueChanged<int?> onChanged;

  const _FilterDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int?>(
          value: value,
          dropdownColor: AppColors.surfaceHigh,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textPrimary,
          ),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textHint, size: 20),
          items: items.entries
              .map(
                (e) => DropdownMenuItem<int?>(
                  value: e.key,
                  child: Text(e.value),
                ),
              )
              .toList(),
          onChanged: (v) => onChanged(v),
        ),
      ),
    );
  }
}
