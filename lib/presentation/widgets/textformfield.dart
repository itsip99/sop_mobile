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
    this.enableUpperCaseText = false,
    this.inputFormatters = const [],
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
  final bool enableUpperCaseText;
  final List<TextInputFormatter> inputFormatters;

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
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          maxLines: 1,
          autofocus: widget.isAutoFocusEnable,
          inputFormatters: widget.inputFormatters,
          textCapitalization: widget.enableUpperCaseText
              ? TextCapitalization.characters
              : TextCapitalization.none,
          controller: widget.controller,
          enabled: true,
          obscureText: widget.isPassword,
          style: TextThemes.textfieldPlaceholder,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white54,
            contentPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
            ),
            hintStyle: TextThemes.textfieldPlaceholder,
            hintText: 'Enter ${widget.hintText}',
            labelText: widget.labelText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            prefixIcon: widget.prefixIcon,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.enableValidator
              ? (() {
                  switch (widget.validatorType) {
                    case 'email':
                      return Validator.emailValidation;
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
