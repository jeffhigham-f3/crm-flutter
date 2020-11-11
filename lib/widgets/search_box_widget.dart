import 'package:flutter/material.dart';

class SearchBoxWidget extends StatelessWidget {
  final Function onChanged;
  SearchBoxWidget({Key key, @required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
      ),
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        onChanged: onChanged,
        autofocus: true,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: '',
          hintStyle: TextStyle(fontSize: 18.0),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
