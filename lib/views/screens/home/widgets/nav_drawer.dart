import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';

import '../../../../bloc/adoption_history/adoption_history_bloc.dart';
import '../../../../bloc/theme/theme_bloc.dart';
import '../../../../utils/app_themes.dart';
import '../../history/history_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8.vdp()),
          children: <Widget>[
            BlocBuilder<ThemeBloc, ThemeData>(
              builder: (context, state) {
                final isDarkTheme = state == AppTheme.darkTheme;
                return ListTile(
                  trailing: Icon(
                    isDarkTheme ? Icons.toggle_on : Icons.toggle_off,
                    size: 50.vdp(),
                    color: isDarkTheme ? Colors.green : Colors.grey,
                  ),
                  title: const Text(
                    "Dark Mode",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    BlocProvider.of<ThemeBloc>(context).add(ToggleThemeEvent());
                  },
                );
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.history,
                size: 40.vdp(),
              ),
              title: const Text(
                'History',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AdoptionHistoryScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
