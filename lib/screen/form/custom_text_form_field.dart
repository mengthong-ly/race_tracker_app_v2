import 'package:flutter/material.dart';

import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_constant.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? initialvalue;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.initialvalue,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TTextTheme.darkTextTheme.bodySmall!
                .copyWith(color: RColor.black),
          ),
          TVerticalSpacing.s,
          SizedBox(
            height: 64, // Reserve space for the error message
            child: TextFormField(
              onSaved: onSaved,
              cursorHeight: 18,
              validator: validator,
              initialValue: initialvalue ?? '',
              style: TTextTheme.darkTextTheme.bodySmall!.copyWith(color: RColor.black, fontWeight: FontWeight.w500),
              cursorColor: RColor.black.withOpacity(0.8),
              decoration: InputDecoration(
                isDense: true,
                constraints: const BoxConstraints(maxHeight: 48, minHeight: 48),
                contentPadding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                hintText: hintText,
                hintStyle: TTextTheme.darkTextTheme.bodySmall,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: RColor.primary,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: RColor.error,
                    width: 1,
                  ),
                ),
                errorStyle: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                  color: RColor.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
