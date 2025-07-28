import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/app_config_provider.dart';
import '../Theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeSheet extends StatefulWidget {
  @override
  State<ThemeSheet> createState() => _ThemeSheetState();
}

class _ThemeSheetState extends State<ThemeSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        // الوضع الداكن
        InkWell(
          onTap: () {
            provider.changeTheme(ThemeMode.dark);
          },
          child: provider.isDark()
              ? selected(AppLocalizations.of(context)!.dark_mode)
              : unselected(AppLocalizations.of(context)!.dark_mode),
        ),

        // الوضع الفاتح
        InkWell(
          onTap: () {
            provider.changeTheme(ThemeMode.light);
          },
          child: !provider.isDark()
              ? selected(AppLocalizations.of(context)!.light_mode)
              : unselected(AppLocalizations.of(context)!.light_mode),
        ),
      ],
    );
  }

  Widget selected(String text) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: MyTheme.primary,
            ),
          ),
          Icon(
            Icons.check,
            color: MyTheme.primary,
          ),
        ],
      ),
    );
  }

  Widget unselected(String text) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
