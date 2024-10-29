import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/nearby_tile.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class NearbyPanel extends StatelessWidget {
  const NearbyPanel({required this.scrollController, super.key});

  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 5,
              decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
                  ? CustomTheme.lightSliderButton
                  : CustomTheme.darkSliderButton,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'Ślady w pobliżu:',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.left,
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.visibility,
                  size: 28,
                ),
              ),
              Gap(8),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.swap_vert,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: 10,
            itemBuilder: (context, index) {
              return NearbyTile();
            },
          ),
        ),
      ],
    );
  }
}
