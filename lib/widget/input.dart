import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({super.key , this.hintText = 'Hint text'});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(

      cursorColor: theme.focusColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodySmall,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.unselectedWidgetColor
          ),
           borderRadius: BorderRadius.circular(AppConstant.borderRadius)
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.focusColor
          ),
           borderRadius: BorderRadius.circular(AppConstant.borderRadius) 
        ),
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(AppConstant.borderRadius)
        )
      ),
    );
  }
}
