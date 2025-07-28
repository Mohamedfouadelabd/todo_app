import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/Settingstap/language_sheet.dart';
import 'package:todo_app/Settingstap/theme_sheet.dart';
import 'package:todo_app/Theme/my_theme.dart';

class SettingTap extends StatefulWidget {
  const SettingTap({super.key});

  @override
  State<SettingTap> createState() => _SettingTapState();
}

class _SettingTapState extends State<SettingTap> {
  @override
  Widget build(BuildContext context) {
  var provider= Provider.of<AppConfigProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          InkWell(
            onTap: () {
              showLanguage();
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: MyTheme.primary),
                  color: MyTheme.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   provider.appLanguage=='en'?
                    AppLocalizations.of(context)!.english:
                   AppLocalizations.of(context)!.arabic
                    ,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: MyTheme.primary,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(AppLocalizations.of(context)!.theme,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          InkWell(
            onTap: () {
              showTheme();
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: MyTheme.primary),
                  color: MyTheme.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   provider.isDark()?AppLocalizations.of(context)!.dark_mode:
                    AppLocalizations.of(context)!.light_mode,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: MyTheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguage() {
    showModalBottomSheet(context: context, builder:(context) {
      return LanguageSheet();
    },);


  }

  void showTheme() {

    showModalBottomSheet(context: context, builder:(context) {
      return ThemeSheet();

    },
    );
  }
}
