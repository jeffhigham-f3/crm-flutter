import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/glance_task.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';
import 'package:faker/faker.dart';
import 'package:animate_do/animate_do.dart';

class ContactFollowUpWidget extends StatefulWidget {
  final GlanceTask task;
  const ContactFollowUpWidget({Key key, this.task}) : super(key: key);

  @override
  _ContactFollowUpWidgetState createState() => _ContactFollowUpWidgetState();
}

class _ContactFollowUpWidgetState extends State<ContactFollowUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 500),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Online Now",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Text(
                  "You need connect with these contacts today.\nNow is a good time!",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 50.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1000',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1001',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1002',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1003',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1004',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1005',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1006',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1007',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1008',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1009',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1010',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1011',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1012',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        imageUrl: 'http://placeimg.com/200/200/people?id=1013',
                        radius: 25.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        isActive: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
