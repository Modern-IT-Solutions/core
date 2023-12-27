import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.profile,
    this.radius = 60
  });

  final ProfileModel? profile;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      // when desibled show red circle
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: profile?.disabled == true ? Border.all(color: Colors.red, width: 2) : Border.all(color: 
          Theme.of(context).colorScheme.primary
        , width: 1),
      ),
      child: Badge(
        // offset: 
        //   // use cos to deter
        //   Offset(0,
        //     cos(pi)
        //   )
        // ,
        isLabelVisible: profile?.disabled == true,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        backgroundColor: Colors.red,
        label: const Row(
          children: [
            Icon(Icons.block, size: 12, color: Colors.white),
            Text(
              "BLOCKED",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10
              ),
            )
          ],
        ),
        child: Padding(
          padding: profile?.disabled == true ? const EdgeInsets.all(2) : const EdgeInsets.all(1),
          child: CircleAvatar(
            radius: radius,
            backgroundImage: profile?.photoUrl.nullIfEmpty == null ? null : NetworkImage(profile!.photoUrl),
            child: profile?.photoUrl.nullIfEmpty != null ? null : Text((profile?.displayName.nullIfEmpty ?? "?")[0].toUpperCase()),
            // child: profile?.photoUrl.nullIfEmpty == null ? null : Text((profile!.displayName.nullIfEmpty ?? "?")[0].toUpperCase()),
          ),
        ),
      ),
    );
  }
}

