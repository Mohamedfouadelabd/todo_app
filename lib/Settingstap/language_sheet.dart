import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/Theme/my_theme.dart';
class LanguageSheet extends StatefulWidget {

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<AppConfigProvider>(context);
    return Column(
      children: [


        InkWell(
          onTap: (){
            provider.changeLanguage('en');

          },
          child: provider.appLanguage == 'en'
              ? selected(AppLocalizations.of(context)!.english)
              : unselected(AppLocalizations.of(context)!.english),



        ),
        InkWell(
         onTap: (){
           provider.changeLanguage('ar');
         },
          child: provider.appLanguage == 'ar'
              ? selected(AppLocalizations.of(context)!.arabic)
              : unselected(AppLocalizations.of(context)!.arabic),

        ),


      ],


    );
  }

Widget selected(String text){
    return   Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: MyTheme.primary
            ),

          ),
          Icon(Icons.check,
            color: MyTheme.primary,

          ),

        ],
      ),
    );

}

  Widget unselected(String text){
    return  Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(context).textTheme.bodyLarge

          ),


        ],
      ),
    );

  }
}
