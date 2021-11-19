import 'package:flutter/material.dart';
import 'package:social_app1/shared/widgets/Posts/searchbar.dart';


class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 6, child: SearchBar()),
        const SizedBox(
          width: 10,
        ),
        Container(
          child: Icon(Icons.menu, size: 30),
        )
      ],
    );
  }
}
