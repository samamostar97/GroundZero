import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/utils/image_utils.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/pagination_controls.dart';
import '../../../shared/widgets/search_input.dart';
import '../data/staff_repository.dart';
import '../models/staff_model.dart';
import '../providers/staff_provider.dart';

class StaffScreen extends ConsumerWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(staffNotifierProvider);

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
                      'Osoblje',
                      style: GoogleFonts.barlowCondensed(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Upravljanje trenerima i nutricionistima',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Staff type filter
              _StaffTypeDropdown(
                value: state.staffTypeFilter,
                onChanged: (value) {
                  ref.read(staffNotifierProvider.notifier).setStaffTypeFilter(value);
                },
              ),
              const SizedBox(width: 12),
              SearchInput(
                hint: 'Pretraži osoblje...',
                onChanged: (value) {
                  ref.read(staffNotifierProvider.notifier).setSearch(value);
                },
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _showStaffDialog(context, ref),
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
          Expanded(child: _buildContent(context, ref, state)),

          // Pagination
          if (!state.isLoading && state.error == null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: PaginationControls(
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                totalCount: state.totalCount,
                onPrevious: () {
                  ref.read(staffNotifierProvider.notifier).loadPage(state.currentPage - 1);
                },
                onNext: () {
                  ref.read(staffNotifierProvider.notifier).loadPage(state.currentPage + 1);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, StaffState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.accent));
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 40, color: AppColors.error),
            const SizedBox(height: 12),
            Text(state.error!, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(staffNotifierProvider.notifier).refresh(),
              child: const Text('Pokušaj ponovo'),
            ),
          ],
        ),
      );
    }

    if (state.staff.isEmpty) {
      return Center(
        child: Text('Nema osoblja.', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textHint)),
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
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Ime i prezime')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Telefon')),
                DataColumn(label: Text('Tip')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Akcije')),
              ],
              rows: state.staff.map((s) {
                return DataRow(cells: [
                  DataCell(Text('#${s.id}')),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _StaffAvatar(
                        imageUrl: s.profileImageUrl,
                        firstName: s.firstName,
                        lastName: s.lastName,
                      ),
                      const SizedBox(width: 10),
                      Text('${s.firstName} ${s.lastName}'),
                    ],
                  )),
                  DataCell(Text(s.email)),
                  DataCell(Text(s.phone ?? '—')),
                  DataCell(_StaffTypeBadge(type: s.staffType)),
                  DataCell(_StatusBadge(isActive: s.isActive)),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ActionButton(
                        icon: Icons.edit_outlined,
                        color: AppColors.accent,
                        tooltip: 'Uredi',
                        onTap: () => _showStaffDialog(context, ref, staff: s),
                      ),
                      const SizedBox(width: 4),
                      _ActionButton(
                        icon: Icons.delete_outline_rounded,
                        color: AppColors.error,
                        tooltip: 'Obriši',
                        onTap: () async {
                          final confirmed = await showConfirmDialog(
                            context: context,
                            title: 'Brisanje osoblja',
                            message: 'Da li ste sigurni da želite obrisati ${s.firstName} ${s.lastName}?',
                            confirmLabel: 'Obriši',
                            isDestructive: true,
                          );
                          if (confirmed) {
                            ref.read(staffNotifierProvider.notifier).deleteStaff(s.id);
                          }
                        },
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

  void _showStaffDialog(BuildContext context, WidgetRef ref, {StaffModel? staff}) {
    showDialog(
      context: context,
      builder: (context) => _StaffFormDialog(
        staff: staff,
        onSave: (data, imagePath) async {
          try {
            int staffId;
            if (staff != null) {
              await ref.read(staffNotifierProvider.notifier).updateStaff(staff.id, data);
              staffId = staff.id;
            } else {
              staffId = await ref.read(staffNotifierProvider.notifier).createStaff(data);
            }
            if (imagePath != null) {
              await ref.read(staffRepositoryProvider).uploadPicture(staffId, imagePath);
              ref.read(staffNotifierProvider.notifier).refresh();
            }
            if (context.mounted) Navigator.of(context).pop();
          } on ApiException catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.firstError)),
              );
            }
          }
        },
      ),
    );
  }
}

// Staff form dialog
class _StaffFormDialog extends StatefulWidget {
  final StaffModel? staff;
  final Future<void> Function(Map<String, dynamic> data, String? imagePath) onSave;

  const _StaffFormDialog({this.staff, required this.onSave});

  @override
  State<_StaffFormDialog> createState() => _StaffFormDialogState();
}

class _StaffFormDialogState extends State<_StaffFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bioController;
  late String _staffType;
  late bool _isActive;
  bool _isSaving = false;
  String? _selectedImagePath;

  bool get isEdit => widget.staff != null;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.staff?.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.staff?.lastName ?? '');
    _emailController = TextEditingController(text: widget.staff?.email ?? '');
    _phoneController = TextEditingController(text: widget.staff?.phone ?? '');
    _bioController = TextEditingController(text: widget.staff?.bio ?? '');
    _staffType = widget.staff?.staffType ?? 'Trainer';
    _isActive = widget.staff?.isActive ?? true;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'Uredi osoblje' : 'Dodaj osoblje'),
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
                          _buildDialogAvatar(),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.surface, width: 2),
                              ),
                              child: const Icon(Icons.camera_alt, size: 14, color: AppColors.onAccent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(labelText: 'Ime'),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Unesite ime.' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(labelText: 'Prezime'),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Unesite prezime.' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Unesite email.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Telefon (opcionalno)'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bioController,
                  decoration: const InputDecoration(labelText: 'Bio (opcionalno)'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _staffType,
                  decoration: const InputDecoration(labelText: 'Tip'),
                  items: const [
                    DropdownMenuItem(value: 'Trainer', child: Text('Trener')),
                    DropdownMenuItem(value: 'Nutritionist', child: Text('Nutricionist')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _staffType = value);
                  },
                ),
                if (isEdit) ...[
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: Text(
                      'Aktivan',
                      style: GoogleFonts.inter(fontSize: 14, color: AppColors.textPrimary),
                    ),
                    value: _isActive,
                    activeThumbColor: AppColors.accent,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) => setState(() => _isActive = value),
                  ),
                ],
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
          style: ElevatedButton.styleFrom(minimumSize: const Size(120, 40)),
          child: _isSaving
              ? const SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onAccent),
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

  Widget _buildDialogAvatar() {
    final initials =
        '${_firstNameController.text.isNotEmpty ? _firstNameController.text[0] : ''}${_lastNameController.text.isNotEmpty ? _lastNameController.text[0] : ''}'
            .toUpperCase();

    if (_selectedImagePath != null) {
      return CircleAvatar(
        radius: 40,
        backgroundImage: FileImage(File(_selectedImagePath!)),
      );
    }

    final existingUrl = ImageUtils.fullImageUrl(widget.staff?.profileImageUrl);
    if (existingUrl != null) {
      return CachedNetworkImage(
        imageUrl: existingUrl,
        imageBuilder: (_, imageProvider) => CircleAvatar(
          radius: 40,
          backgroundImage: imageProvider,
        ),
        placeholder: (_, _) => CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.accent,
          child: Text(initials, style: const TextStyle(color: AppColors.onAccent, fontWeight: FontWeight.w700, fontSize: 28)),
        ),
        errorWidget: (_, _, _) => CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.accent,
          child: Text(initials, style: const TextStyle(color: AppColors.onAccent, fontWeight: FontWeight.w700, fontSize: 28)),
        ),
      );
    }

    return CircleAvatar(
      radius: 40,
      backgroundColor: AppColors.accent,
      child: Text(
        initials.isEmpty ? '+' : initials,
        style: const TextStyle(color: AppColors.onAccent, fontWeight: FontWeight.w700, fontSize: 28),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final data = {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      'bio': _bioController.text.trim().isEmpty ? null : _bioController.text.trim(),
      'staffType': _staffType,
      if (isEdit) 'isActive': _isActive,
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

// Reusable widgets
class _StaffAvatar extends StatelessWidget {
  final String? imageUrl;
  final String firstName;
  final String lastName;

  const _StaffAvatar({this.imageUrl, required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    final initials =
        '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
            .toUpperCase();
    final fullUrl = ImageUtils.fullImageUrl(imageUrl);

    if (fullUrl != null) {
      return CachedNetworkImage(
        imageUrl: fullUrl,
        imageBuilder: (_, imageProvider) => CircleAvatar(
          radius: 16,
          backgroundImage: imageProvider,
        ),
        placeholder: (_, _) => _initialsAvatar(initials),
        errorWidget: (_, _, _) => _initialsAvatar(initials),
      );
    }

    return _initialsAvatar(initials);
  }

  Widget _initialsAvatar(String initials) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: AppColors.accent,
      child: Text(
        initials,
        style: const TextStyle(
          color: AppColors.onAccent,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _StaffTypeBadge extends StatelessWidget {
  final String type;
  const _StaffTypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final isTrainer = type == 'Trainer';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (isTrainer ? AppColors.accent : AppColors.warning).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isTrainer ? 'Trener' : 'Nutricionist',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isTrainer ? AppColors.accent : AppColors.warning,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isActive;
  const _StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (isActive ? AppColors.success : AppColors.error).withValues(alpha: 0.1),
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

class _StaffTypeDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const _StaffTypeDropdown({this.value, required this.onChanged});

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
        child: DropdownButton<String>(
          value: value,
          hint: Text('Svi tipovi', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint)),
          style: GoogleFonts.inter(fontSize: 13, color: AppColors.textPrimary),
          dropdownColor: AppColors.surfaceHigh,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.textHint),
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text('Svi tipovi', style: GoogleFonts.inter(fontSize: 13)),
            ),
            DropdownMenuItem(
              value: 'Trainer',
              child: Text('Treneri', style: GoogleFonts.inter(fontSize: 13)),
            ),
            DropdownMenuItem(
              value: 'Nutritionist',
              child: Text('Nutricionisti', style: GoogleFonts.inter(fontSize: 13)),
            ),
          ],
          onChanged: onChanged,
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
              color: _isHovered ? widget.color.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(widget.icon, size: 18, color: widget.color),
          ),
        ),
      ),
    );
  }
}
