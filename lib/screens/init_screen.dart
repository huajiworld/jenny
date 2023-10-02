import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jenny/basic/commons.dart';
import 'package:jenny/basic/methods.dart';
import 'package:jenny/configs/configs.dart';
import 'package:jenny/configs/login.dart';
import 'package:jenny/configs/passed.dart';
import 'package:jenny/screens/calculator_screen.dart';

import '../basic/web_dav_sync.dart';
import 'app_screen.dart';
import 'first_login_screen.dart';
import 'network_setting_screen.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/backpoint.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "lib/assets/startup.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _init() async {
    try {
      await methods.init();
      await initConfigs();
       
        Future.delayed(Duration.zero, () async {
          await webDavSyncAuto(context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) {
              return const AppScreen();
            }),
          );
        });
      
    } catch (e, st) {
      print("$e\n$st");
      defaultToast(context, "初始化失败, 请设置网络");
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) {
            return const NetworkSettingScreen();
          }),
        );
      });
    }
  }
}
