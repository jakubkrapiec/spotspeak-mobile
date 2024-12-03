import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/models/other_user.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';

class HorizontalUserList extends StatelessWidget {
  const HorizontalUserList({required this.friendsList, required this.emptyText, super.key});

  final List<OtherUser> friendsList;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: friendsList.isEmpty
          ? Center(child: Text(emptyText))
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: friendsList.length,
              separatorBuilder: (context, index) => const Gap(16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final friend = friendsList[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => context.router.push(UserProfileRoute(userId: friend.id)),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: friend.profilePictureUrl?.toString() ?? '',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/default_icon.jpg',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(friend.username),
                  ],
                );
              },
            ),
    );
  }
}
