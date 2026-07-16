import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: 0,

      labelType: NavigationRailLabelType.all,

      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard),
          label: Text("Dashboard"),
        ),

        NavigationRailDestination(
          icon: Icon(Icons.point_of_sale),
          label: Text("POS"),
        ),

        NavigationRailDestination(
          icon: Icon(Icons.inventory),
          label: Text("Products"),
        ),

        NavigationRailDestination(
          icon: Icon(Icons.category),
          label: Text("Categories"),
        ),

        NavigationRailDestination(
          icon: Icon(Icons.people),
          label: Text("Customers"),
        ),

        NavigationRailDestination(
          icon: Icon(Icons.local_shipping),
          label: Text("Suppliers"),
        ),

        NavigationRailDestination(
          icon: Icon(Icons.bar_chart),
          label: Text("Reports"),
        ),
      ],
    );
  }
}
