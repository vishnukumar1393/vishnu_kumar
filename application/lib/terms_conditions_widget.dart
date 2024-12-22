import 'package:flutter/material.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  TermsAndConditionsWidget({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I accept the Terms and Conditions:',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                '- Data Privacy: We keep your data safe and use it only to manage your account.\n'
                    '- Account Responsibility: Don’t share your password or account details.\n'
                    '- Prohibited Activities: Don’t misuse the platform or spam others.\n'
                    '- Content Ownership: Only upload content that you own or have rights to.\n'
                    '- Account Termination: Breaking the rules may lead to your account being closed.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
