// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/colors_theme.dart';

class InputTextField extends StatefulWidget {
  final Key? controlKey;
  final Key? showPasswordKey;
  final String? initValue;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final InputBorder? focusedBorder;
  final InputBorder? enableBorder;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool? isPassword;
  final TextEditingController? controller;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  final String? title;

  const InputTextField(
      {this.controlKey,
      this.showPasswordKey,
      this.initValue,
      this.textStyle,
      this.hintText,
      this.hintStyle,
      this.suffixIcon,
      this.validator,
      this.onChanged,
      this.isPassword,
      this.controller,
      this.maxLength,
      this.formatters,
      this.focusedBorder,
      this.enableBorder,
      this.title})
      : super(key: controlKey);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    var defaultHintStyle = Theme.of(context).textTheme.bodyMedium;
    const defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff9F7493)),
    );
    if (widget.initValue != null) {
      widget.controller!.text = widget.initValue!;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.neutral70)),
              TextSpan(
                  text: ' *',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.primayRed)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          child: TextFormField(
              key: widget.controlKey,
              controller: widget.controller,
              onChanged: widget.onChanged,
              obscureText: (widget.isPassword ?? false) ? _isObscure : false,
              inputFormatters: widget.formatters,
              keyboardType: TextInputType.text,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: widget.textStyle,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                isDense: true,
                counterText: '',
                contentPadding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                //TODO: change color
                errorStyle:
                    defaultHintStyle?.copyWith(color: Colors.red, height: 0.8),
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ?? defaultHintStyle,
                suffixIconConstraints: const BoxConstraints(maxHeight: 20),
                suffixIcon: widget.suffixIcon ??
                    ((widget.isPassword ?? false) ? _buildSuffixIcon() : null),
                //TODO: change color

                focusedBorder: widget.focusedBorder ?? defaultBorder,
                enabledBorder: widget.enableBorder ?? defaultBorder,

                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                border: const UnderlineInputBorder(borderSide: BorderSide()),
                //TODO: change color

                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildSuffixIcon() {
    return IconButton(
        key: widget.showPasswordKey,
        padding: const EdgeInsets.all(0),
        icon: Icon(
            _isObscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: const Color(0xff5E224E),
            size: 20),
        onPressed: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        });
  }
}
