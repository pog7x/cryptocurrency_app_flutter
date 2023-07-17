import 'package:flutter/material.dart';

import 'package:cryptocurrency_app/generated/l10n.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).somethingWentWrong,
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            S.of(context).pleaseTryAgainLater,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: widget.onPressed,
            child: Text(S.of(context).tryAgain),
          )
        ],
      ),
    );
  }
}
