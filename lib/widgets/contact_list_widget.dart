import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/contact_detail_screen.dart';
import 'package:verb_crm_flutter/models/contact.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';

class ContactListWidget extends StatefulWidget {
  final Contact contact;
  const ContactListWidget({Key key, this.contact}) : super(key: key);

  @override
  _ContactListWidgetState createState() => _ContactListWidgetState();
}

class _ContactListWidgetState extends State<ContactListWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        seconds: 1,
      ),
      child: Card(
        child: InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetailScreen(
                  contact: widget.contact,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileAvatar(
                            imageUrl: widget.contact.photoUrl,
                            radius: 25.0,
                            backgroundColor: Colors.white,
                            borderColor: widget.contact.accentColor,
                            hasBorder: true,
                            isActive: widget.contact.online,
                            initials: widget.contact.initials,
                          ),
                          SizedBox(width: 20),
                          Text(
                            widget.contact.firstName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.contact.lastName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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
