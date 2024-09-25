import 'package:flutter/material.dart';
import 'package:to_do/appColors.dart';

class RegisterTextformfield extends StatelessWidget {
String label;
String? Function(String?)? validator;
TextEditingController controller ;
TextInputType keyboardType;
bool obsecureText;
RegisterTextformfield({required this.label,
  required this.validator, required this.controller,
  this.keyboardType=TextInputType.text, this.obsecureText=false});
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      decoration: InputDecoration(
          labelText:label,
              enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),borderSide: BorderSide(
      color: appColors.mainLightColor,
                width: 1.5
    )
      ),focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),borderSide: BorderSide(
          color: appColors.mainLightColor,
        width: 3
      )
      ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),borderSide: BorderSide(
            color: appColors.red,
            width: 3
        )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),borderSide: BorderSide(
            color: appColors.red,
            width: 3
        )
        ),
      ),
      validator: validator,
      controller: controller,
      keyboardType:keyboardType,
      obscureText:obsecureText ,
    );
  }
}
