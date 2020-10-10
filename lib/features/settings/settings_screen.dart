import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/signup_signin/view/passworrd_change_screen.dart';
import 'package:jobxprss_company/main_app/repositories/app_info_repository.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  String appVersion = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.settingsText, key: Key('settingsAppBarTextKey'),),
      ),
      body: ListView(
        children: <Widget>[
//          ListTile(
//            leading: Icon(
//              FontAwesomeIcons.solidMoon,
//              size: 22,
//            ),
//            title: Text(StringUtils.darkModeText),
//            trailing: Consumer<ConfigProvider>(
//              builder: (context, configProvider,s) {
//                return Switch(
//                  onChanged: (bool value) {
//                    configProvider.toggleThemeChangeEvent();
//                  },
//                  value: configProvider.isDarkModeOn,
//                );
//              }
//            ),
//          ),
//          Divider(height: 2,),

          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ChangePasswordScreen()));
            },
            leading: Icon(
              Icons.lock_open,
            ),
            title: Text(StringResources.changePassword),
            key: Key('goIntoChangePassword'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => LicensePage(
                        applicationLegalese: "Copyright © 2020 Job Search",
                        applicationVersion: appVersion,
                            applicationIcon: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(kDefaultLogoFull))
                              ),
                            ),
                          )));
            },
            leading: Icon(
              Icons.featured_play_list,
            ),
            title: Text(StringResources.licenses),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.infoCircle,
              size: 22,
            ),
            title: FutureBuilder(
              future: AppInfoRepository().getAppVersion(),
              builder: (c, snapshot) {
                appVersion = snapshot.data??"";
                return Text(
                snapshot.hasData ? "Version: ${snapshot.data}" : "",
                style: TextStyle(color: Colors.grey),
              );
              },
            ),
          )
        ],
      ),
    );
  }
}
