import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var items = [1, 2, 3, 4, 5, 6];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/default_icon.jpg',
          ),
        ),
        Text('Username', style: Theme.of(context).textTheme.bodyLarge),
        Text('2137 pkt', style: Theme.of(context).textTheme.bodySmall),
        ListTile(
          title: Text('Wyślij zaproszenie do znajomych'),
          leading: Icon(Icons.people),
        ),
        Text('Wspólni znajomi:'),
        // ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //   itemCount: items.length,
        //   itemBuilder: (context, index) {
        //     return GestureDetector(
        //       onTap: () {},
        //       child: Container(
        //         margin: const EdgeInsets.all(5.0),
        //         padding: const EdgeInsets.all(5.0),
        //         width: 90.0,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black.withOpacity(0.2),
        //               spreadRadius: 2,
        //               blurRadius: 8,
        //               offset: const Offset(5, 3),
        //             ),
        //           ],
        //         ),
        //         child: Center(
        //           child: FittedBox(
        //             fit: BoxFit.scaleDown,
        //             child: Text(
        //               'fsds',
        //               maxLines: 3,
        //               textAlign: TextAlign.center,
        //               style: const TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 18.0,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
