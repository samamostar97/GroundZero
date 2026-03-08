import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/utils/image_utils.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/pagination_controls.dart';
import '../../../shared/widgets/search_input.dart';
import '../../../shared/widgets/snackbar_helpers.dart';
import '../../categories/models/category_model.dart';
import '../../categories/providers/categories_provider.dart';
import '../data/products_repository.dart';
import '../models/product_model.dart';
import '../providers/products_provider.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsNotifierProvider);
    final categoriesState = ref.watch(categoriesNotifierProvider);

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
                      'Proizvodi',
                      style: GoogleFonts.barlowCondensed(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Upravljanje proizvodima i zalihama',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Category filter
              _CategoryFilterDropdown(
                categories: categoriesState.categories,
                value: state.categoryFilter,
                onChanged: (value) {
                  ref
                      .read(productsNotifierProvider.notifier)
                      .setCategoryFilter(value);
                },
              ),
              const SizedBox(width: 12),
              SearchInput(
                hint: 'Pretraži proizvode...',
                onChanged: (value) {
                  ref
                      .read(productsNotifierProvider.notifier)
                      .setSearch(value);
                },
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _showProductDialog(product: null),
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
                      .read(productsNotifierProvider.notifier)
                      .loadPage(state.currentPage - 1);
                },
                onNext: () {
                  ref
                      .read(productsNotifierProvider.notifier)
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
      'name' => 1,
      'categoryName' => 2,
      'price' => 3,
      'stockQuantity' => 4,
      _ => null,
    };
  }

  Widget _buildContent(ProductsState state) {
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
                  ref.read(productsNotifierProvider.notifier).refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (state.products.isEmpty) {
      return Center(
        child: Text('Nema proizvoda.',
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
              sortColumnIndex: _sortColumnIndex(state.sortBy),
              sortAscending: !state.sortDescending,
              columns: [
                DataColumn(label: const Text('ID'), onSort: (_, __) => ref.read(productsNotifierProvider.notifier).setSort('id')),
                DataColumn(label: const Text('Naziv'), onSort: (_, __) => ref.read(productsNotifierProvider.notifier).setSort('name')),
                DataColumn(label: const Text('Kategorija'), onSort: (_, __) => ref.read(productsNotifierProvider.notifier).setSort('categoryName')),
                DataColumn(label: const Text('Cijena'), numeric: true, onSort: (_, __) => ref.read(productsNotifierProvider.notifier).setSort('price')),
                DataColumn(label: const Text('Stanje'), numeric: true, onSort: (_, __) => ref.read(productsNotifierProvider.notifier).setSort('stockQuantity')),
                const DataColumn(label: Text('Akcije')),
              ],
              rows: state.products.map((p) {
                return DataRow(cells: [
                  DataCell(Text('#${p.id}')),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ProductImage(
                        imageUrl: p.imageUrl,
                        name: p.name,
                      ),
                      const SizedBox(width: 10),
                      Flexible(child: Text(p.name, overflow: TextOverflow.ellipsis)),
                    ],
                  )),
                  DataCell(Text(p.categoryName)),
                  DataCell(Text('${p.price.toStringAsFixed(2)} KM')),
                  DataCell(_StockBadge(quantity: p.stockQuantity)),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ActionButton(
                        icon: Icons.edit_outlined,
                        color: AppColors.accent,
                        tooltip: 'Uredi',
                        onTap: () => _showProductDialog(product: p),
                      ),
                      const SizedBox(width: 4),
                      _ActionButton(
                        icon: Icons.delete_outline_rounded,
                        color: AppColors.error,
                        tooltip: 'Obriši',
                        onTap: () => _deleteProduct(p),
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

  Future<void> _deleteProduct(ProductModel p) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: 'Brisanje proizvoda',
      message: 'Da li ste sigurni da želite obrisati "${p.name}"?',
      confirmLabel: 'Obriši',
      isDestructive: true,
    );
    if (confirmed) {
      try {
        await ref
            .read(productsNotifierProvider.notifier)
            .deleteProduct(p.id);
        if (mounted) showSuccessSnackBar(context, 'Proizvod uspješno obrisan.');
      } on ApiException catch (e) {
        if (mounted) showErrorSnackBar(context, e.firstError);
      }
    }
  }

  void _showProductDialog({ProductModel? product}) {
    showDialog(
      context: context,
      builder: (dialogContext) => _ProductFormDialog(
        product: product,
        onSave: (data, imagePath) async {
          try {
            int productId;
            if (product != null) {
              await ref
                  .read(productsNotifierProvider.notifier)
                  .updateProduct(product.id, data);
              productId = product.id;
            } else {
              productId = await ref
                  .read(productsNotifierProvider.notifier)
                  .createProduct(data);
            }
            if (imagePath != null) {
              await ref
                  .read(productsRepositoryProvider)
                  .uploadImage(productId, imagePath);
              ref.read(productsNotifierProvider.notifier).refresh();
            }
            if (dialogContext.mounted) Navigator.of(dialogContext).pop();
            if (mounted) {
              showSuccessSnackBar(
                context,
                product != null
                    ? 'Proizvod uspješno ažuriran.'
                    : 'Proizvod uspješno kreiran.',
              );
            }
          } on ApiException catch (e) {
            if (dialogContext.mounted) showErrorSnackBar(dialogContext, e.firstError);
          }
        },
      ),
    );
  }
}

// Product form dialog
class _ProductFormDialog extends ConsumerStatefulWidget {
  final ProductModel? product;
  final Future<void> Function(Map<String, dynamic> data, String? imagePath)
      onSave;

  const _ProductFormDialog({this.product, required this.onSave});

  @override
  ConsumerState<_ProductFormDialog> createState() =>
      _ProductFormDialogState();
}

class _ProductFormDialogState extends ConsumerState<_ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  int? _selectedCategoryId;
  bool _isSaving = false;
  String? _selectedImagePath;

  bool get isEdit => widget.product != null;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.product?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _priceController = TextEditingController(
        text: widget.product?.price.toStringAsFixed(2) ?? '');
    _stockController = TextEditingController(
        text: widget.product?.stockQuantity.toString() ?? '');
    _selectedCategoryId = widget.product?.categoryId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesNotifierProvider);

    return AlertDialog(
      title: Text(isEdit ? 'Uredi proizvod' : 'Dodaj proizvod'),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image picker
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Stack(
                        children: [
                          _buildDialogImage(),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.surface, width: 2),
                              ),
                              child: const Icon(Icons.camera_alt,
                                  size: 14, color: AppColors.onAccent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                        decoration:
                            const InputDecoration(labelText: 'Cijena (KM)'),
                        keyboardType: const TextInputType.numberWithOptions(
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
                        controller: _stockController,
                        decoration:
                            const InputDecoration(labelText: 'Stanje'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Unesite stanje.';
                          }
                          final stock = int.tryParse(v);
                          if (stock == null || stock < 0) {
                            return 'Stanje ne može biti negativno.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  initialValue: _selectedCategoryId,
                  decoration:
                      const InputDecoration(labelText: 'Kategorija'),
                  items: categoriesState.categories.map((c) {
                    return DropdownMenuItem(
                      value: c.id,
                      child: Text(c.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCategoryId = value);
                  },
                  validator: (v) =>
                      v == null ? 'Odaberite kategoriju.' : null,
                ),
              ],
            ),
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

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null && result.files.single.path != null) {
      setState(() => _selectedImagePath = result.files.single.path);
    }
  }

  Widget _buildDialogImage() {
    const size = 80.0;

    if (_selectedImagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(_selectedImagePath!),
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }

    final existingUrl = ImageUtils.fullImageUrl(widget.product?.imageUrl);
    if (existingUrl != null) {
      return CachedNetworkImage(
        imageUrl: existingUrl,
        imageBuilder: (_, imageProvider) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image(
              image: imageProvider,
              width: size,
              height: size,
              fit: BoxFit.cover),
        ),
        placeholder: (_, _) => _placeholderImage(size),
        errorWidget: (_, _, _) => _placeholderImage(size),
      );
    }

    return _placeholderImage(size);
  }

  Widget _placeholderImage(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.inventory_2_outlined,
          size: 32, color: AppColors.textHint),
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
      'stockQuantity': int.parse(_stockController.text.trim()),
      'categoryId': _selectedCategoryId,
    };

    try {
      await widget.onSave(data, _selectedImagePath);
    } catch (_) {
      // Error handled in onSave callback
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

// Product image thumbnail in table
class _ProductImage extends StatelessWidget {
  final String? imageUrl;
  final String name;

  const _ProductImage({this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    final fullUrl = ImageUtils.fullImageUrl(imageUrl);

    if (fullUrl != null) {
      return CachedNetworkImage(
        imageUrl: fullUrl,
        imageBuilder: (_, imageProvider) => ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image(
              image: imageProvider,
              width: 36,
              height: 36,
              fit: BoxFit.cover),
        ),
        placeholder: (_, _) => _placeholder(),
        errorWidget: (_, _, _) => _placeholder(),
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(Icons.inventory_2_outlined,
          size: 16, color: AppColors.textHint),
    );
  }
}

// Stock badge (color-coded by quantity)
class _StockBadge extends StatelessWidget {
  final int quantity;
  const _StockBadge({required this.quantity});

  @override
  Widget build(BuildContext context) {
    final Color color;
    if (quantity == 0) {
      color = AppColors.error;
    } else if (quantity <= 5) {
      color = AppColors.warning;
    } else {
      color = AppColors.success;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$quantity kom.',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// Category filter dropdown
class _CategoryFilterDropdown extends StatelessWidget {
  final List<CategoryModel> categories;
  final int? value;
  final ValueChanged<int?> onChanged;

  const _CategoryFilterDropdown({
    required this.categories,
    this.value,
    required this.onChanged,
  });

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
        child: DropdownButton<int?>(
          value: value,
          hint: Text('Sve kategorije',
              style: GoogleFonts.inter(
                  fontSize: 13, color: AppColors.textHint)),
          style:
              GoogleFonts.inter(fontSize: 13, color: AppColors.textPrimary),
          dropdownColor: AppColors.surfaceHigh,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.textHint),
          items: [
            DropdownMenuItem<int?>(
              value: null,
              child: Text('Sve kategorije',
                  style: GoogleFonts.inter(fontSize: 13)),
            ),
            ...categories.map((c) {
              return DropdownMenuItem<int?>(
                value: c.id,
                child:
                    Text(c.name, style: GoogleFonts.inter(fontSize: 13)),
              );
            }),
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
