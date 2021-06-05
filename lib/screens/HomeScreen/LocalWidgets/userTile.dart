import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String photoURL;
  final String joinedOn;
  const UserTile(
      {Key key,
      @required this.name,
      @required this.photoURL,
      @required this.joinedOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(photoURL),
            radius: 35,
          ),
          SizedBox(width: 2.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.9,
                  ),
                ),
                Text(
                  "Joined on ${joinedOn}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
