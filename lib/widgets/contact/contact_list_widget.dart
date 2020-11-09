import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/contact_detail_screen.dart';
import 'package:verb_crm_flutter/models/contact/contact.dart';
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
          splashColor: Theme.of(context).accentColor.withOpacity(0.1),
          highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonDetailScreen(
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
                          Hero(
                            tag: 'profile-${widget.contact.id}',
                            child: ProfileAvatar(
                              imageUrl: widget.contact.photoUrl,
                              radius: 25.0,
                              backgroundColor: widget.contact.accentColor,
                              borderColor: Colors.white,
                              hasBorder: true,
                              isActive: widget.contact.online,
                              initials: widget.contact.initials,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text('${widget.contact.firstName} ${widget.contact.lastName}'),
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
