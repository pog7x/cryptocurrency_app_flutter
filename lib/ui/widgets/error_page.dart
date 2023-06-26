import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Something went wrong',
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            'Please try again later',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: onPressed,
            child: const Text('Try again'),
          )
        ],
      ),
    );
  }
}
