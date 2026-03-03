import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/image_utils.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String firstName;
  final String lastName;
  final double radius;

  const UserAvatar({
    super.key,
    this.imageUrl,
    required this.firstName,
    required this.lastName,
    this.radius = 28,
  });

  @override
  Widget build(BuildContext context) {
    final fullUrl = ImageUtils.fullImageUrl(imageUrl);

    if (fullUrl != null) {
      return CachedNetworkImage(
        imageUrl: fullUrl,
        imageBuilder: (_, imageProvider) => CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        ),
        placeholder: (_, _) => _initialsAvatar(),
        errorWidget: (_, _, _) => _initialsAvatar(),
      );
    }

    return _initialsAvatar();
  }

  Widget _initialsAvatar() {
    final initials =
        '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
            .toUpperCase();

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.accent,
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.onAccent,
          fontWeight: FontWeight.w700,
          fontSize: radius * 0.7,
        ),
      ),
    );
  }
}
