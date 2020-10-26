import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/auth_service.dart';
import 'package:verb_crm_flutter/service/tray_io/tray_io_user_service.dart';
import 'package:verb_crm_flutter/screens/login_screen.dart';
import 'package:verb_crm_flutter/widgets/gradient_container.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final trayUserService = context.watch<TrayIOUserService>();

    return (authService.isSignedIn)
        ? Scaffold(
            body: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverAppBar(
                  floating: true,
                  title: Text(authService.currentUser.name),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        child: ProfileAvatar(
                          imageUrl: authService.currentUser.photoUrl,
                          radius: 60.0,
                          backgroundColor: Theme.of(context).accentColor,
                          borderColor: Theme.of(context).accentColor,
                          initials: authService.currentUser.initials,
                          hasBorder: true,
                          isActive: false,
                        ),
                      ),
                      Text('Auth User:'),
                      Text(authService.currentUser.toString()),
                      Text('TrayIO User'),
                      Text(trayUserService.currentUser.toString()),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: OutlineButton(
                      onPressed: () => {
                        authService.signOut(),
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.id,
                          (Route<dynamic> route) => false,
                        ),
                      },
                      child: Text('Sign Out'),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(body: GradientContainer());
  }
}
