import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/config/import.dart';
import 'package:verb_crm_flutter/service/auth/import.dart';
import 'package:verb_crm_flutter/screens/login_screen.dart';
import 'package:verb_crm_flutter/service/import.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final themeService = context.watch<ThemeService>();

    return (authService.isSignedIn)
        ? Scaffold(
            body: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverAppBar(
                  collapsedHeight: 200,
                  expandedHeight: 200,
                  flexibleSpace: Container(
                    decoration: themeService.appBarGradientDecoration,
                    child: _ProfileNavAvatar(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      Card(
                        child: InkWell(
                          onTap: () => print("Authentication"),
                          splashColor: Theme.of(context).accentColor.withOpacity(0.1),
                          highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Authentication',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(authService.currentUser.authProvider),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () => print("Email"),
                          splashColor: Theme.of(context).accentColor.withOpacity(0.1),
                          highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Email',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(authService.currentUser.email),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 22.0, 8.0, 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => themeService.setTheme(theme: Palette.theme1),
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: Palette.theme1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "Blue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => themeService.setTheme(theme: Palette.theme2),
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: Palette.theme2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "Green",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  // fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => themeService.setTheme(theme: Palette.theme3),
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: Palette.theme3,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "Orange",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  // fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
        : SizedBox.shrink();
  }
}

class _ProfileNavAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 40,
          ),
          child: Hero(
            tag: 'profile-${authService.currentUser.id}',
            child: ProfileAvatar(
              imageUrl: authService.currentUser.photoUrl,
              radius: 60.0,
              backgroundColor: Theme.of(context).accentColor,
              borderColor: Colors.white,
              hasBorder: true,
              isActive: false,
              initials: authService.currentUser.initials,
            ),
          ),
        ),
        Text(
          'Profile',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline6.fontSize,
            fontWeight: Theme.of(context).textTheme.headline6.fontWeight,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
