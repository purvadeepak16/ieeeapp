import 'package:flutter/material.dart';
import 'package:ieee_app/widgets/wie_widgets/wie_body.dart';
import 'package:ieee_app/widgets/app_drawer.dart';

class WiePage extends StatelessWidget {
  const WiePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: const WieBody(),
    ); 
  }
}
