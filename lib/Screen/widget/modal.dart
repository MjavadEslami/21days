import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String message;

  const CustomDialog({
    super.key,
    required this.message,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                          color: Colors.black.withOpacity(.5), width: 1),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text('باشه'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
