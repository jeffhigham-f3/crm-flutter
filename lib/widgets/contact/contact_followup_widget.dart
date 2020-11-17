import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/contact/contact.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/contact/contact_service.dart';
import 'package:verb_crm_flutter/screens/contact_detail_screen.dart';

class ContactFollowUpWidget extends StatelessWidget {
  const ContactFollowUpWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Available Now",
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
            _ContactRowSlider(),
          ],
        ),
      ),
    );
  }
}

class _ContactRowSlider extends StatelessWidget {
  const _ContactRowSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();
    return Container(
      height: 100.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: contactService.followUpContacts.length,
          itemBuilder: (context, index) {
            return _ContactContainer(contact: contactService.followUpContacts[index]);
          }),
    );
  }
}

class _ContactContainer extends StatelessWidget {
  final Contact contact;

  const _ContactContainer({
    Key key,
    @required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          width: 100,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 55,
                  margin: EdgeInsets.only(right: 10.0),
                  child: Hero(
                    tag: 'profile-${contact.id}',
                    child: ProfileAvatar(
                      imageUrl: contact.photoUrl,
                      imageAsset: contact.photoAsset,
                      radius: 32.0,
                      backgroundColor: contact.accentColor,
                      borderColor: Colors.white,
                      isActive: contact.online,
                      initials: contact.initials,
                      hasBorder: true,
                      // sourceIcon: contact.sourceIcon,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${contact.firstName}'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
