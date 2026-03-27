import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee_app/core/auth/auth_controller.dart';
import 'package:ieee_app/core/auth/auth_provider.dart';
import 'package:ieee_app/core/constants/app_constants.dart';

class VerifyEmailScreen extends ConsumerWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthUiState>(authControllerProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
      if (next.successMessage != null && next.successMessage != previous?.successMessage) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.successMessage!)));
      }
    });

    final authState = ref.watch(authControllerProvider);
    final user = ref.watch(authRepositoryProvider).currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Text(
              'A verification link has been sent to ${user?.email ?? 'your email'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            const Text(
              'Please verify your email, then tap "I have verified".',
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: authState.isLoading
                    ? null
                    : () async {
                        try {
                          final verified = await ref
                              .read(authControllerProvider.notifier)
                              .refreshVerificationStatus();
                          if (!context.mounted) {
                            return;
                          }
                          if (verified) {
                            context.go(AppConstants.homePath);
                          }
                        } catch (_) {}
                      },
                child: authState.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('I have verified'),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: authState.isLoading
                  ? null
                  : () async {
                      try {
                        await ref
                            .read(authControllerProvider.notifier)
                            .resendVerificationEmail();
                      } catch (_) {}
                    },
              child: const Text('Resend verification email'),
            ),
            const Spacer(),
            TextButton(
              onPressed: authState.isLoading
                  ? null
                  : () async {
                      try {
                        await ref.read(authControllerProvider.notifier).signOut();
                        if (!context.mounted) {
                          return;
                        }
                        context.go(AppConstants.loginPath);
                      } catch (_) {}
                    },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
