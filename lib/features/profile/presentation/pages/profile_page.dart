import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          children: [
            const Expanded(child: Center(child: Text('Profile module coming in Phase 8'))),
            CustomButton(
              label: 'Logout',
              type: ButtonType.outline,
              icon: Icons.logout_rounded,
              onPressed: () => context.go(RouteNames.login),
            ),
          ],
        ),
      ),
    );
  }
}