import 'package:flutter/cupertino.dart';

Future<void> showLogoutDialog(
  BuildContext context,
  VoidCallback onConfirm,
  String text,
) async {
  return showCupertinoDialog(
    context: context,
    builder:
        (_) => CupertinoAlertDialog(
          content: Column(
            mainAxisSize:
                MainAxisSize.min, // Fix overflow issue on small devices
            children: [
              const SizedBox(height: 10),
              ClipOval(
                child: Image.asset(
                  'assets/Inven.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'InvenTech',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.activeBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
  );
}
