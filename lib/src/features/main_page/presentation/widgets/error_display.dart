import 'package:flutter/material.dart';
import 'package:sunshine_test/src/common/string_consts.dart';
import 'package:sunshine_test/src/features/main_page/presentation/widgets/gradient_button.dart';

class ErrorDisplay extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorDisplay({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 20),
          GradientButton(
            onPressed: onRetry,
            text: StringConsts.retryButtonString,
          ),
        ],
      ),
    );
  }
}
