import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showDeleteConfirmationDialog(
  BuildContext context, {
  String itemName = "This Items",
}) async {
  final result = await showCupertinoDialog<bool>(
    context: context,
    builder:
        (context) => CupertinoAlertDialog(
          title: const Text('Delete Products Confirmation'),
          content: Text('Are you sure you want to delete $itemName?'),
          actions: [
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
  );
  return result ?? false;
}
