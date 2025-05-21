import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sop_mobile/core/helpers/validator.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.controller, {
    this.isAutoFocusEnable = false,
    this.isPassword = false,
    this.enableValidator = false,
    this.validatorType = '',
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters = const [],
    this.isLabelFloat = false,
    this.borderRadius = 10,
    super.key,
  });

  final String hintText;
  final String labelText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final bool isAutoFocusEnable;
  final bool isPassword;
  final bool enableValidator;
  final String validatorType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;
  final bool isLabelFloat;
  final double borderRadius;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        alignment: Alignment.center,
        child: TextFormField(
          maxLines: 1,
          autofocus: widget.isAutoFocusEnable,
          focusNode: FocusNode(canRequestFocus: false),
          inputFormatters: widget.inputFormatters,
          textCapitalization: widget.textCapitalization,
          controller: widget.controller,
          enabled: true,
          obscureText: widget.isPassword,
          style: TextThemes.textfieldPlaceholder,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white54,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            hintStyle: TextThemes.textfieldPlaceholder,
            hintText: 'Enter ${widget.hintText}',
            labelText: widget.labelText,
            floatingLabelBehavior: widget.isLabelFloat
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.auto,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
            ),
            prefixIcon: widget.prefixIcon,
            helperText: widget.enableValidator ? ' ' : null,
            helperStyle: const TextStyle(height: 1),
            errorStyle: const TextStyle(height: 1),
            // suffixIcon: widget.validatorType == 'password'
            //     ? IconButton(
            //         icon: Icon(
            //           widget.isPassword
            //               ? Icons.visibility_off
            //               : Icons.visibility,
            //         ),
            //         onPressed: () {
            //           setState(() {
            //             // Toggle the obscureText property by updating the parent widget
            //             Navigator.of(context).push(
            //               PageRouteBuilder(
            //                 opaque: false,
            //                 pageBuilder: (_, __, ___) => CustomTextFormField(
            //                   widget.hintText,
            //                   widget.labelText,
            //                   widget.prefixIcon,
            //                   widget.controller,
            //                   isAutoFocusEnable: widget.isAutoFocusEnable,
            //                   isPassword: !widget.isPassword,
            //                   enableValidator: widget.enableValidator,
            //                   validatorType: widget.validatorType,
            //                   enableUpperCaseText: widget.enableUpperCaseText,
            //                   inputFormatters: widget.inputFormatters,
            //                   isLabelFloat: widget.isLabelFloat,
            //                   borderRadius: widget.borderRadius,
            //                 ),
            //               ),
            //             );
            //           });
            //         },
            //       )
            //     : null,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.enableValidator
              ? (() {
                  switch (widget.validatorType) {
                    case 'email':
                      return Validator.emailValidation;
                    case 'name':
                      return Validator.nameValidator;
                    case 'username':
                      return Validator.usernameValidator;
                    case 'password':
                      return Validator.passwordValidation;
                    default:
                      return null;
                  }
                })()
              : null,
          onChanged: (newValues) {},
        ),
      ),
    );
  }
}
