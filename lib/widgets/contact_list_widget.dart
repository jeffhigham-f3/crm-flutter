import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/contact_detail_screen.dart';

class ContactListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactDetailScreen(
//                  task: this.contact,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Container()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
