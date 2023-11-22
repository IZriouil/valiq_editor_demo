import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/layout_constants.dart';

// define a callback function to handle validator
typedef Validator = String? Function(String? value);
typedef Saver = void Function(String? value);

enum FieldType { text, name, textarea, email, number, phone, date }

enum FieldStyle { uppercase, lowercase, capitalize, none }

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Validator? validator;
  final Saver? onSave;
  final Saver? onChange;
  final String label;
  final String hint;
  final String? initValue;
  final int? maxLength;
  final bool disabled;
  final bool required;
  final bool obscure;
  final FieldType? type;
  final FieldStyle? style;
  final bool allowSpace;
  final Color fillColor;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry padding;

  const TextFieldWidget(
      {Key? key,
      required this.label,
      required this.hint,
      this.controller,
      this.onSave,
      this.style = FieldStyle.none,
      this.type = FieldType.text,
      this.disabled = false,
      this.required = false,
      this.obscure = false,
      this.allowSpace = true,
      this.maxLength,
      this.fillColor = Colors.transparent,
      this.validator,
      this.suffixIcon,
      this.padding = EdgeInsets.zero,
      this.initValue,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initValue : null,
        enabled: !disabled,
        obscureText: obscure,
        onSaved: onSave,
        onChanged: onChange,
        maxLength: maxLength,
        minLines: type == FieldType.textarea ? 4 : 1,
        maxLines: type == FieldType.textarea ? 6 : 1,
        style: Theme.of(context).textTheme.bodyMedium,
        keyboardType: _getKeyboardType(),
        validator: (value) {
          if (required && value!.isEmpty) {
            return "This field is required";
          }
          // if (type == FieldType.email && !value!.isEmail()) {
          //   return "Invalid email address";
          // }

          // if (type == FieldType.phone && !value!.isPhone()) {
          //   return "Invalid phone number";
          // }

          // if (type == FieldType.date) {
          //   if (!value!.isDate() && value.isNotEmpty) {
          //     return "Invalid date";
          //   }
          // }

          if (validator != null) {
            return validator!(value);
          }
          return null;
        },
        decoration: InputDecoration(
            // suffixIcon: suffixIcon,
            // fillColor: fillColor,
            // filled: true,
            // errorMaxLines: 2,
            // labelText: label,
            counter: type == FieldType.textarea ? null : const Offstage(),
            counterStyle:
                Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).dividerColor),
            // errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red[400]),
            // labelStyle: Theme.of(context).textTheme.bodySmall!,
            hintText: hint,
            // focusedBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.white24, width: 1),
            //   borderRadius: BorderRadius.circular(kDefaultPadding),
            // ),
            // enabledBorder: OutlineInputBorder(
            // borderSide: const BorderSide(color: Colors.white24, width: .4),
            // borderRadius: BorderRadius.circular(kDefaultPadding),
            // ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(kDefaultPadding / 2))),
        // inputFormatters: _getInputFormatter(),
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (type) {
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.number:
        return TextInputType.number;
      case FieldType.name:
        return TextInputType.name;
      case FieldType.textarea:
        return TextInputType.multiline;
      case FieldType.date:
        return TextInputType.datetime;
      case FieldType.phone:
        return TextInputType.phone;
      default:
        return TextInputType.none;
    }
  }

//   List<TextInputFormatter> _getInputFormatter() {
//     List<TextInputFormatter> formatters = [];

//     if (maxLength != null) {
//       formatters.add(LengthLimitingTextInputFormatter(maxLength));
//     }

//     if (!allowSpace) {
//       formatters.add(WithoutSpaceTextFormatter());
//     }

//     switch (style) {
//       case FieldStyle.uppercase:
//         formatters.add(UpperCaseTextFormatter());
//         break;
//       case FieldStyle.lowercase:
//         formatters.add(LowerCaseTextFormatter());
//         break;
//       case FieldStyle.capitalize:
//         formatters.add(CapitalizeTextFormatter());
//         break;
//       default:
//     }

//     switch (type) {
//       case FieldType.date:
//         formatters.add(DateTextFormatter());
//         break;
//       // case FieldType.phone:
//       //   const String format = "+212 x xx xx xx xx";
//       //   formatters.add(MaskedTextInputFormatter(mask: format, separator: ' '));
//       //   break;
//       default:
//     }

//     return formatters;
//   }
}
