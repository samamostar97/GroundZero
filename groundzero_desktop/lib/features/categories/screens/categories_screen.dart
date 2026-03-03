import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_exception.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/search_input.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../models/category_model.dart';
import '../providers/categories_provider.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  List<CategoryModel> _sorted(List<CategoryModel> list) {
    final sorted = List<CategoryModel>.from(list);
    sorted.sort((a, b) {
      final result = switch (_sortColumnIndex) {
        0 => a.id.compareTo(b.id),
        1 => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
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
    final state = ref.watch(categoriesNotifierProvider);

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
                      'Kategorije',
                      style: GoogleFonts.barlowCondensed(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Upravljanje kategorijama proizvoda',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SearchInput(
                hint: 'Pretraži kategorije...',
                onChanged: (value) {
                  ref
                      .read(categoriesNotifierProvider.notifier)
                      .setSearch(value);
                },
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _showCategoryDialog(category: null),
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

  Widget _buildContent(CategoriesState state) {
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
              onPressed: () =>
                  ref.read(categoriesNotifierProvider.notifier).refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    final categories = _sorted(state.filtered);

    if (categories.isEmpty) {
      return Center(
        child: Text('Nema kategorija.',
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
                const DataColumn(label: Text('Opis')),
                const DataColumn(label: Text('Akcije')),
              ],
              rows: categories.map((c) {
                return DataRow(cells: [
                  DataCell(Text('#${c.id}')),
                  DataCell(Text(c.name)),
                  DataCell(Text(c.description ?? '—')),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ActionButton(
                        icon: Icons.edit_outlined,
                        color: AppColors.accent,
                        tooltip: 'Uredi',
                        onTap: () => _showCategoryDialog(category: c),
                      ),
                      const SizedBox(width: 4),
                      _ActionButton(
                        icon: Icons.delete_outline_rounded,
                        color: AppColors.error,
                        tooltip: 'Obriši',
                        onTap: () => _deleteCategory(c),
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

  Future<void> _deleteCategory(CategoryModel c) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: 'Brisanje kategorije',
      message:
          'Da li ste sigurni da želite obrisati kategoriju "${c.name}"?',
      confirmLabel: 'Obriši',
      isDestructive: true,
    );
    if (confirmed) {
      try {
        await ref
            .read(categoriesNotifierProvider.notifier)
            .deleteCategory(c.id);
        if (mounted) showSuccessSnackBar(context, 'Kategorija uspješno obrisana.');
      } on ApiException catch (e) {
        if (mounted) showErrorSnackBar(context, e.firstError);
      }
    }
  }

  void _showCategoryDialog({CategoryModel? category}) {
    showDialog(
      context: context,
      builder: (dialogContext) => _CategoryFormDialog(
        category: category,
        onSave: (data) async {
          try {
            if (category != null) {
              await ref
                  .read(categoriesNotifierProvider.notifier)
                  .updateCategory(category.id, data);
              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
              if (mounted) showSuccessSnackBar(context, 'Kategorija uspješno ažurirana.');
            } else {
              await ref
                  .read(categoriesNotifierProvider.notifier)
                  .createCategory(data);
              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
              if (mounted) showSuccessSnackBar(context, 'Kategorija uspješno kreirana.');
            }
          } on ApiException catch (e) {
            if (dialogContext.mounted) showErrorSnackBar(dialogContext, e.firstError);
          }
        },
      ),
    );
  }
}

// Category form dialog
class _CategoryFormDialog extends StatefulWidget {
  final CategoryModel? category;
  final Future<void> Function(Map<String, dynamic> data) onSave;

  const _CategoryFormDialog({this.category, required this.onSave});

  @override
  State<_CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<_CategoryFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  bool _isSaving = false;

  bool get isEdit => widget.category != null;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.category?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.category?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'Uredi kategoriju' : 'Dodaj kategoriju'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Naziv'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Unesite naziv.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Opis (opcionalno)'),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Otkaži'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _save,
          style: ElevatedButton.styleFrom(minimumSize: const Size(120, 40)),
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
