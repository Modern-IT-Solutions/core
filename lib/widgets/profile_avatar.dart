import 'dart:math';

import 'package:puncher/puncher.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.profile, this.radius = 60});

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
        border: profile?.disabled == true ? Border.all(color: Colors.red, 
        
        width: (radius != null && radius! < 25) ? 1 : 2
        
        ) : Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
      ),
      child: Badge(
        // offset:
        //   // use cos to deter
        //   Offset(0,
        //     cos(pi)
        //   )
        // ,
        isLabelVisible: profile?.disabled == true && !(radius != null && radius! < 25),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        backgroundColor: Colors.red,
        label: const Row(
          children: [
            Icon(Icons.block, size: 12, color: Colors.white),
            // Text(
            //   "BLOCK",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 6
            //   ),
            // )
          ],
        ),
        child: Padding(
          padding: profile?.disabled == true ? const EdgeInsets.all(2) : const EdgeInsets.all(1),
          child: CircleAvatar(
            radius: radius,
            backgroundImage: profile?.photoUrl.nullIfEmpty == null ? null : NetworkImage(profile!.photoUrl),
            child:  
              profile?.photoUrl.nullIfEmpty != null ? null : 
                Text((profile?.displayName.nullIfEmpty ?? "?")[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: radius != null && radius! < 25 ? 10 : 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                  ),
                ),
            // child: profile?.photoUrl.nullIfEmpty == null ? null : Text((profile!.displayName.nullIfEmpty ?? "?")[0].toUpperCase()),
          ),
        ),
      ),
    );
  }
}

class NestedProfileAvatars extends StatelessWidget {
  /// [profiles] is the list of profiles to be used
  final List<ProfileModel?> profiles;
  /// [radius] is the radius of the outer circle or the shape
  final double radius;
  const NestedProfileAvatars({
    super.key,
    required this.profiles,
    this.radius = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (profiles.isNotEmpty)
        for (var i = 0; i < profiles.length; i++)
          NestedPuncher(
            enabled: i != profiles.length - 1,
            overlap: 0.6,
            margin: 1,
            radius: radius,
            punchers: [
            ],
            child: ProfileAvatar(
              radius: radius,
              profile: profiles[i]),
          ),
      ],
    );
  }
}
