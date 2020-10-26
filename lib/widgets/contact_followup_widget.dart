import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/glance_task.dart';
import 'package:verb_crm_flutter/models/contact.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/contact_service.dart';
import 'package:verb_crm_flutter/screens/contact_detail_screen.dart';
import 'package:verb_crm_flutter/service/tray_io/tray_io_solution_instance_service.dart';

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
      delay: Duration(seconds: 3),
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
      ),
    );
  }
}

class _ContactRowSlider extends StatefulWidget {
  const _ContactRowSlider({
    Key key,
  }) : super(key: key);

  @override
  __ContactRowSliderState createState() => __ContactRowSliderState();
}

class __ContactRowSliderState extends State<_ContactRowSlider> {
  @override
  void initState() {
    final solutionInstanceService = context.read<TrayIOSolutionInstanceService>();
    final contactService = context.read<ContactService>();

    // TODO: Replace the workflow request with
    if (solutionInstanceService.activeInstances.length != 0 &&
        solutionInstanceService.activeInstances.first.workflows.length != 0) {
      final instance = solutionInstanceService.activeInstances.first;
      if (!instance.enabled) {
        print('Solution Instance [${instance.id}] ${instance.name} is disabled');
        return;
      }

      final workflow = instance.workflows.first;
      if (workflow == null) {
        print('${instance.name} does not have an active workflow.');
        return;
      }
      print('Fetching contacts from triggerUrl: ${workflow.triggerUrl}');
      contactService.getContacts(workflowUrl: workflow.triggerUrl);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();

    return Container(
      height: 100.0,
      child: StreamBuilder(
        stream: contactService.stream,
        builder: (context, snapshot) {
          List<Widget> widgets = [];
          if (!snapshot.hasData || snapshot.data.length == 0) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          for (var contact in snapshot.data) {
            if (contact.online && contact.followUp) {
              widgets.add(
                _ContactContainer(contact: contact),
              );
            }
          }
          return ListView(
            scrollDirection: Axis.horizontal,
            children: widgets,
          );
        },
      ),
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
            builder: (context) => ContactDetailScreen(
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
                  height: 45,
                  margin: EdgeInsets.only(right: 10.0),
                  child: ProfileAvatar(
                    imageUrl: contact.photoUrl,
                    radius: 30.0,
                    backgroundColor: contact.accentColor,
                    borderColor: Colors.white,
                    isActive: contact.online,
                    initials: contact.initials,
                    hasBorder: true,
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
