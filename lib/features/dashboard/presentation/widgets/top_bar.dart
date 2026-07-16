import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Stock Vente POS"),

      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),

          child: CircleAvatar(child: Icon(Icons.person)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
