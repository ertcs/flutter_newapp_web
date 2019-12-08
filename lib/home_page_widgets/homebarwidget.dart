import 'package:flutter/material.dart';
import 'package:flutter_newapp_web/util/appUtil.dart';

class UserImageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        elevation: 16,
        color: Colors.transparent,
        shadowColor: Colors.white30,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(userImage),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                bottom: 30,
              ),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 2),
                    shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  '1',
                  style: notificationText,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
