import 'package:flutter/material.dart';

/// {@template ccp_default_modal_title}
/// The default modal title if widget is not provided.
/// {@endtemplate}
class CcpDefaultModalTitle extends StatelessWidget {
  /// {@macro ccp_default_modal_title}
  const CcpDefaultModalTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headlineMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        'Select Country',
        style: style,
      ),
    );
  }
}
