import 'package:flutter/material.dart';

import '../constant.dart';

class PlaningHeader extends StatelessWidget {
  const PlaningHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Orders",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 240.0,),
            Text(
              "View All",
              style: TextStyle(color: kDarkBlue, height: 2),
            )
          ],
        ),
      ],
    );
  }
}
