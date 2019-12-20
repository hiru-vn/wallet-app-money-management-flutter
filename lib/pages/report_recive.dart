import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money/login.dart';
import 'package:money/report/search_recieve.dart';
import 'package:money/report/tab_recive_month.dart';
import 'package:money/report/tab_recive_week.dart';
import 'package:money/report/tab_recive_year.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ReportRecive extends StatefulWidget {
  _ReportReciveState createState() => _ReportReciveState();
}

class _ReportReciveState extends State<ReportRecive> {
  
  /*========== Login expired ================*/
  Future<Null> checkloginexiped() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMMddhm');
    String formatted = formatter.format(now);
    if (int.parse(formatted) >= prefs.getInt('time')) {
      prefs.remove('token');
      prefs.remove('time');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      prefs.setInt('time', int.parse(formatted) + 10);
    }
  }
void initState() { 
  super.initState();
  checkloginexiped();
}
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length:3,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => SearchRecieve()));
              },
            )
          ],
            bottom: TabBar(
              tabs: [
                Tab(child: Column(children: <Widget>[
                  Icon(Icons.devices,),
                  Text('ອາ​ທິດ')
                ],)),
                Tab(child: Column(children: <Widget>[
                  Icon(Icons.important_devices),
                  Text('​ເດືອນ')
                ],)),
                Tab(child: Column(children: <Widget>[
                  Icon(Icons.computer),
                  Text('​ປີ')
                ],)),
              ],
            ),
            title: Text('ລາຍ​ງານ​ລາຍ​ຮັບ'),
          ),
          body: TabBarView(
            children: [
               TabReciveWeek(),
              TabReciveMonth(),
              TabReciveYear(),
            ],
            
          ),
        ),
    
    );
  }
}