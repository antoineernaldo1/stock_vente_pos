import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/side_menu.dart';
import '../widgets/top_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Row(
        children: [
          const SideMenu(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  const DashboardCard(
                    title: "Today's Sales",
                    value: "\$0.00",
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),

                  const DashboardCard(
                    title: "Products",
                    value: "0",
                    icon: Icons.inventory_2,
                    color: Colors.blue,
                  ),

                  const DashboardCard(
                    title: "Customers",
                    value: "0",
                    icon: Icons.people,
                    color: Colors.orange,
                  ),

                  const DashboardCard(
                    title: "Low Stock",
                    value: "0",
                    icon: Icons.warning_amber_rounded,
                    color: Colors.red,
                  ),

                  DashboardCard(
                    title: "Point Of Sale",
                    value: "Open POS",
                    icon: Icons.point_of_sale,
                    color: Colors.deepPurple,
                    onTap: () {
                      context.go(AppRoutes.pos);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
