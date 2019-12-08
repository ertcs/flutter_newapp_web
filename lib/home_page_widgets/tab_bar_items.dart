import 'package:flutter/material.dart';
import 'package:flutter_newapp_web/datamodel/tabBarModel.dart';

class TabBarItems extends StatelessWidget {
  final TabBarModel tabBarModel;
  final bool isSelected;
  final int tabIndex;
  final Function changeTab;

  TabBarItems(
      {this.tabBarModel, this.isSelected, this.tabIndex, this.changeTab});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeTab(tabIndex),
      child: Padding(
        padding: isSelected
            ? EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10)
            : EdgeInsets.only(right: 10, top: 8, bottom: 8, left: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '${tabBarModel.tabTitle}',
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.black54,
                  fontFamily: 'Exo2',
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: isSelected ? 20 : 16,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                height: 2,
                width: tabBarModel.tabTitle.length * 8.toDouble(),
                color:
                    isSelected ? Colors.deepOrangeAccent : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
