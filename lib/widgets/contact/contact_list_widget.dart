import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/contact_detail_screen.dart';
import 'package:verb_crm_flutter/models/contact/contact.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';

class ContactListWidget extends StatelessWidget {
  final Contact contact;
  const ContactListWidget({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        seconds: 1,
      ),
      child: Card(
        child: InkWell(
          splashColor: Theme.of(context).accentColor.withOpacity(0.1),
          highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonDetailScreen(
                  contact: contact,
                ),
                fullscreenDialog: true,
              ),
            )
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Hero(
                                tag: 'profile-${contact.id}',
                                child: ProfileAvatar(
                                  imageUrl: contact.photoUrl,
                                  imageAsset: contact.photoAsset,
                                  radius: 25.0,
                                  backgroundColor: contact.accentColor,
                                  borderColor: Colors.white,
                                  hasBorder: true,
                                  isActive: contact.online,
                                  initials: contact.initials,
                                  sourceIcon: contact.sourceIcon,
                                ),
                              ),
                              // Positioned(
                              //   left: 0.0,
                              //   bottom: 0.0,
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       color: Colors.white,
                              //     ),
                              //     padding: EdgeInsets.all(2.0),
                              //     child: Icon(
                              //       contact.sourceIcon,
                              //       color: Colors.grey[500],
                              //       size: 12.0,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(width: 20),
                          Text('${contact.firstName} ${contact.lastName}'),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
