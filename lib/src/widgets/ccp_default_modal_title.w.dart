import 'package:flutter/material.dart';

/// {@template ccp_default_modal_title}
/// The default modal title if widget is not provided.
/// {@endtemplate}
class CcpDefaultModalTitle extends StatelessWidget {
  /// {@macro ccp_default_modal_title}
  const CcpDefaultModalTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Select your country',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
