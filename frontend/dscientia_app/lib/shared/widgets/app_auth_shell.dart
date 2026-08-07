import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';
import 'app_hero_card.dart';
import 'app_page_shell.dart';

class AppAuthShell extends StatelessWidget {
  const AppAuthShell({
    super.key,
    required this.appBarTitle,
    required this.title,
    required this.description,
    required this.icon,
    required this.child,
  });

  final String appBarTitle;
  final String title;
  final String description;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppPageShell(
      appBar: AppBar(title: Text(appBarTitle)),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeroCard(title: title, description: description, icon: icon),
              const SizedBox(height: AppSpacing.lg),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
