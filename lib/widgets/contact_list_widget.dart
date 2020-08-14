import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/contact_detail_screen.dart';
import 'package:verb_crm_flutter/models/contact.dart';

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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Theme.of(context).accentColor,
                            child: CircleAvatar(
                              backgroundImage: (widget.contact.photoUrl != null)
                                  ? NetworkImage(
                                      widget.contact.photoUrl,
                                    )
                                  : null,
                              radius: 23,
                              backgroundColor: Theme.of(context).canvasColor,
                              child: (widget.contact.photoUrl == null)
                                  ? Text(
                                      widget.contact.initials,
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 42.0,
                                      ),
                                    )
                                  : null,
                            ),
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
