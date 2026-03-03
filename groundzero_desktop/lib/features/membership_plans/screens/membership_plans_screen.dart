import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_exception.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/search_input.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../models/membership_plan_model.dart';
import '../providers/membership_plans_provider.dart';

class MembershipPlansScreen extends ConsumerStatefulWidget {
  const MembershipPlansScreen({super.key});

  @override
  ConsumerState<MembershipPlansScreen> createState() =>
      _MembershipPlansScreenState();
}

class _MembershipPlansScreenState
    extends ConsumerState<MembershipPlansScreen> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  List<MembershipPlanModel> _sorted(List<MembershipPlanModel> list) {
    final sorted = List<MembershipPlanModel>.from(list);
    sorted.sort((a, b) {
      final result = switch (_sortColumnIndex) {
        0 => a.id.compareTo(b.id),
        1 => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        2 => a.price.compareTo(b.price),
        3 => a.durationDays.compareTo(b.durationDays),
        _ => 0,
      };
      return _sortAscending ? result : -result;
    });
    return sorted;
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(membershipPlansNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Planovi članarina',
                      style: GoogleFonts.barlowCondensed(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Upravljanje planovima članarina',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Active filter
              _ActiveFilterDropdown(
                value: state.activeFilter,
                onChanged: (value) {
                  ref
                      .read(membershipPlansNotifierProvider.notifier)
                      .setActiveFilter(value);
                },
              ),
              const SizedBox(width: 12),
              SearchInput(
                hint: 'Pretraži planove...',
                onChanged: (value) {
                  ref
                      .read(membershipPlansNotifierProvider.notifier)
                      .setSearch(value);
                },
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _showPlanDialog(plan: null),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Dodaj'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 40),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Table
          Expanded(child: _buildContent(state)),
        ],
      ),
    );
  }

  Widget _buildContent(MembershipPlansState state) {
    if (state.isLoading) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.accent));
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 40, color: AppColors.error),
            const SizedBox(height: 12),
            Text(state.error!,
                style: GoogleFonts.inter(
                    fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref
                  .read(membershipPlansNotifierProvider.notifier)
                  .refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    final plans = _sorted(state.filtered);

    if (plans.isEmpty) {
      return Center(
        child: Text('Nema planova članarina.',
            style: GoogleFonts.inter(
                fontSize: 14, color: AppColors.textHint)),
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
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              columns: [
                DataColumn(label: const Text('ID'), onSort: _onSort),
                DataColumn(label: const Text('Naziv'), onSort: _onSort),
                DataColumn(label: const Text('Cijena'), onSort: _onSort, numeric: true),
                DataColumn(label: const Text('Trajanje'), onSort: _onSort, numeric: true),
                const DataColumn(label: Text('Status')),
                const DataColumn(label: Text('Akcije')),
              ],
              rows: plans.map((p) {
                return DataRow(cells: [
                  DataCell(Text('#${p.id}')),
                  DataCell(Text(p.name)),
                  DataCell(Text('${p.price.toStringAsFixed(2)} KM')),
                  DataCell(Text(_formatDuration(p.durationDays))),
                  DataCell(_StatusBadge(isActive: p.isActive)),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ActionButton(
                        icon: Icons.edit_outlined,
                        color: AppColors.accent,
                        tooltip: 'Uredi',
                        onTap: () => _showPlanDialog(plan: p),
                      ),
                      const SizedBox(width: 4),
                      _ActionButton(
                        icon: Icons.delete_outline_rounded,
                        color: AppColors.error,
                        tooltip: 'Obriši',
                        onTap: () => _deletePlan(p),
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(int days) {
    if (days == 30 || days == 31) return '1 mjesec';
    if (days == 60 || days == 62) return '2 mjeseca';
    if (days == 90 || days == 92 || days == 93) return '3 mjeseca';
    if (days == 180 || days == 183) return '6 mjeseci';
    if (days == 365 || days == 366) return '1 godina';
    return '$days dana';
  }

  Future<void> _deletePlan(MembershipPlanModel p) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: 'Brisanje plana',
      message: 'Da li ste sigurni da želite obrisati plan "${p.name}"?',
      confirmLabel: 'Obriši',
      isDestructive: true,
    );
    if (confirmed) {
      try {
        await ref
            .read(membershipPlansNotifierProvider.notifier)
            .deletePlan(p.id);
        if (mounted) showSuccessSnackBar(context, 'Plan uspješno obrisan.');
      } on ApiException catch (e) {
        if (mounted) showErrorSnackBar(context, e.firstError);
      }
    }
  }

  void _showPlanDialog({MembershipPlanModel? plan}) {
    showDialog(
      context: context,
      builder: (dialogContext) => _PlanFormDialog(
        plan: plan,
        onSave: (data) async {
          try {
            if (plan != null) {
              await ref
                  .read(membershipPlansNotifierProvider.notifier)
                  .updatePlan(plan.id, data);
              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
              if (mounted) showSuccessSnackBar(context, 'Plan uspješno ažuriran.');
            } else {
              await ref
                  .read(membershipPlansNotifierProvider.notifier)
                  .createPlan(data);
              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
              if (mounted) showSuccessSnackBar(context, 'Plan uspješno kreiran.');
            }
          } on ApiException catch (e) {
            if (dialogContext.mounted) showErrorSnackBar(dialogContext, e.firstError);
          }
        },
      ),
    );
  }
}

// Plan form dialog
class _PlanFormDialog extends StatefulWidget {
  final MembershipPlanModel? plan;
  final Future<void> Function(Map<String, dynamic> data) onSave;

  const _PlanFormDialog({this.plan, required this.onSave});

  @override
  State<_PlanFormDialog> createState() => _PlanFormDialogState();
}

class _PlanFormDialogState extends State<_PlanFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _durationController;
  late bool _isActive;
  bool _isSaving = false;

  bool get isEdit => widget.plan != null;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.plan?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.plan?.description ?? '');
    _priceController = TextEditingController(
        text: widget.plan?.price.toStringAsFixed(2) ?? '');
    _durationController = TextEditingController(
        text: widget.plan?.durationDays.toString() ?? '');
    _isActive = widget.plan?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'Uredi plan' : 'Dodaj plan'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Naziv'),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Unesite naziv.'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      labelText: 'Opis (opcionalno)'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                            labelText: 'Cijena (KM)'),
                        keyboardType:
                            const TextInputType.numberWithOptions(
                                decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Unesite cijenu.';
                          }
                          final price = double.tryParse(v);
                          if (price == null || price <= 0) {
                            return 'Cijena mora biti veća od 0.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _durationController,
                        decoration: const InputDecoration(
                            labelText: 'Trajanje (dana)'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Unesite trajanje.';
                          }
                          final days = int.tryParse(v);
                          if (days == null || days <= 0) {
                            return 'Trajanje mora biti veće od 0.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                if (isEdit) ...[
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: Text(
                      'Aktivan',
                      style: GoogleFonts.inter(
                          fontSize: 14, color: AppColors.textPrimary),
                    ),
                    value: _isActive,
                    activeThumbColor: AppColors.accent,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) =>
                        setState(() => _isActive = value),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Otkaži'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _save,
          style:
              ElevatedButton.styleFrom(minimumSize: const Size(120, 40)),
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: AppColors.onAccent),
                )
              : Text(isEdit ? 'Sačuvaj' : 'Dodaj'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final data = {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      'price': double.parse(_priceController.text.trim()),
      'durationDays': int.parse(_durationController.text.trim()),
      if (isEdit) 'isActive': _isActive,
    };

    try {
      await widget.onSave(data);
    } catch (_) {
      // Error handled in onSave callback
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

// Status badge
class _StatusBadge extends StatelessWidget {
  final bool isActive;
  const _StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (isActive ? AppColors.success : AppColors.error)
            .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? 'Aktivan' : 'Neaktivan',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.success : AppColors.error,
        ),
      ),
    );
  }
}

// Active filter dropdown
class _ActiveFilterDropdown extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?> onChanged;

  const _ActiveFilterDropdown({this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<bool?>(
          value: value,
          hint: Text('Svi statusi',
              style: GoogleFonts.inter(
                  fontSize: 13, color: AppColors.textHint)),
          style: GoogleFonts.inter(
              fontSize: 13, color: AppColors.textPrimary),
          dropdownColor: AppColors.surfaceHigh,
          icon: const Icon(Icons.arrow_drop_down,
              color: AppColors.textHint),
          items: [
            DropdownMenuItem<bool?>(
              value: null,
              child: Text('Svi statusi',
                  style: GoogleFonts.inter(fontSize: 13)),
            ),
            DropdownMenuItem<bool?>(
              value: true,
              child: Text('Aktivni',
                  style: GoogleFonts.inter(fontSize: 13)),
            ),
            DropdownMenuItem<bool?>(
              value: false,
              child: Text('Neaktivni',
                  style: GoogleFonts.inter(fontSize: 13)),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// Action button (hover-animated)
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
