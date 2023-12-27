import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.profile,
  });

  final ProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      // when desibled show red circle
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: profile?.disabled == true ? Border.all(color: Colors.red, width: 2) : null,
      ),
      child: Badge(
        isLabelVisible: profile?.disabled == true,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        backgroundColor: Colors.red,
        label: profile?.disabled == true ? const Icon(Icons.block, size: 12, color: Colors.white) : null,
        child: Padding(
          padding: profile?.disabled == true ? const EdgeInsets.all(2) : const EdgeInsets.all(0),
          child: CircleAvatar(
            backgroundImage: profile?.photoUrl.nullIfEmpty == null ? null : NetworkImage(profile!.photoUrl),
            child: profile?.photoUrl.nullIfEmpty != null ? null : Text((profile?.displayName.nullIfEmpty ?? "?")[0].toUpperCase()),
            // child: profile?.photoUrl.nullIfEmpty == null ? null : Text((profile!.displayName.nullIfEmpty ?? "?")[0].toUpperCase()),
          ),
        ),
      ),
    );
  }
}

