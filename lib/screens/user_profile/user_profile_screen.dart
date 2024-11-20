import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/common/widgets/horizontal_user_list.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/other_user.dart';
import 'package:spotspeak_mobile/screens/user_profile/widgets/friendship_status_bar.dart';
import 'package:spotspeak_mobile/screens/user_profile/widgets/manage_request_buttons.dart';
import 'package:spotspeak_mobile/screens/user_profile/widgets/send_request_button.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

enum FriendshipStatus {
  friends,
  request,
  stranger,
}

@RoutePage()
class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({required this.status, super.key});

  final _appService = getIt<AppService>();

  final FriendshipStatus status;

  @override
  Widget build(BuildContext context) {
    var items = [1, 2, 3, 4, 5, 6];
    return Scaffold(
      appBar: AppBar(
        title: Text('Username'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipOval(
              child: Image.asset(
                'assets/default_icon.jpg',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Username', style: Theme.of(context).textTheme.bodyLarge),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('2137 pkt', style: Theme.of(context).textTheme.bodySmall),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: status == FriendshipStatus.friends
                ? FriendshipStatusBar()
                : status == FriendshipStatus.request
                    ? ManageRequestButtons()
                    : SendRequestButton(),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Wspólni znajomi:'),
            ),
          ),
          HorizontalUserList(
            friendsList: [
              OtherUser(id: '12312', username: 'dsadas'),
              OtherUser(id: '42342', username: 'aaaa'),
              OtherUser(id: '4342', username: 'anka'),
              OtherUser(id: '1231', username: 'username'),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Zdobyte osiągnięcia:'),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (context, index) => Gap(24),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(10),
                    width: 120,
                    decoration: _appService.isDarkMode(context)
                        ? CustomTheme.darkContainerStyle
                        : CustomTheme.lightContainerStyle,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bed_rounded),
                          Text(
                            'nazwa',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
