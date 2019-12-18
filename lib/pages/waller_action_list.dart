import 'package:wallet_exe/enums/colors.dart';
import 'package:wallet_exe/enums/images.dart';
import 'package:wallet_exe/enums/strings/string_keys.dart';
import 'package:wallet_exe/pages/e_wallet/e_wallet_screen.dart';
import 'package:wallet_exe/pages/e_wallet/upgrade_screen.dart';
import 'package:wallet_exe/pages/menu/menu_item_view.dart';
import 'package:wallet_exe/utils/localization.dart';
import 'package:flutter/material.dart';

class EwalletActionList extends StatefulWidget {
  @override
  _EwalletActionListState createState() => _EwalletActionListState();
}

class _EwalletActionListState extends State<EwalletActionList> {

  void _navigateToEwallet(EwalletScreenMode mode) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return EwalletScreen( initialMode: mode,);
        },
      ),
    );
  }
  void _navigateToUpgradeScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return UpgradeScreen( );
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MenuItemView(
          onTap:() => _navigateToEwallet(EwalletScreenMode.exchange) ,
          textColor: AppColors.accentColor,
          title: Localization.getString(Strings.exchange),
          icon: SvgPicture.asset(
            Img.icExchange,
            width: 24.0,
          ),
        ),
        MenuItemView(
          onTap:() => _navigateToEwallet(EwalletScreenMode.euro) ,
          textColor: Colors.white,
          title: Localization.getString(Strings.euroWallet),
          icon: SvgPicture.asset(
            Img.icEuro,
            width: 16.0,
          ),
        ),
        MenuItemView(
          onTap:() => _navigateToEwallet(EwalletScreenMode.ant) ,
          textColor: Colors.white,
          title: Localization.getString(Strings.antWallet),
          icon: SvgPicture.asset(
            Img.icAnt,
            width: 22.0,
          ),
        ),
        MenuItemView(
          onTap:() => _navigateToEwallet(EwalletScreenMode.chart) ,
          textColor: Colors.white,
          title: Localization.getString(Strings.realTimeChart),
          icon: SvgPicture.asset(
            Img.icChart,
            width: 28.0,
          ),
        ),
        MenuItemView(
          onTap:() => _navigateToUpgradeScreen() ,
          textColor: Colors.white,
          title: Localization.getString(Strings.upgradeToStandard),
          icon: SvgPicture.asset(
            Img.icUpgrade,
            width: 18.0,
          ),
        ),
      ],
    );
  }
}
