import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution_instance.dart';

class SolutionInstanceWidget extends StatefulWidget {
  final TraySolutionInstance instance;

  const SolutionInstanceWidget({Key key, this.instance}) : super(key: key);

  @override
  _SolutionInstanceWidgetState createState() => _SolutionInstanceWidgetState();
}

class _SolutionInstanceWidgetState extends State<SolutionInstanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => {
          print("Instance Tapped")
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => GlanceDetailScreen(
//              instance: widget.instance,
//            ),
//            fullscreenDialog: true,
//          ),
//        )
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
                children: [
                  Text(
                    widget.instance.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    widget.instance.id,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
