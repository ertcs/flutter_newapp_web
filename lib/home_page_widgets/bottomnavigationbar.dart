import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_newapp_web/datamodel/tabbardata.dart';
import 'package:flutter_newapp_web/datamodel/bottomnavmodel.dart';

class BottomNavigationMenu extends StatefulWidget {
  @override
  _BottomNavigationMenuState createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabBarData>(
      builder: (context, data, child) {
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                _buildBarItem(data.bottomItems, data.bottomIndex, (index) {
              data.setBottomBarIndex(index: index);
            }),
          ),
        );
      },
    );
  }

  List<Widget> _buildBarItem(
      List<BottomNavModel> list, int index, Function tabFunction) {
    List<Widget> itemList = [];

    for (int i = 0; i < list.length; i++) {
      bool isSelected = index == i;
      BottomNavModel navModel = list[i];
      itemList.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () => tabFunction(i),
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12.0),
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              isSelected
                  ? Text("")
                  : Icon(
                      navModel.itemIcon,
                      color: Colors.black,
                    ),
              AnimatedSize(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  vsync: this,
                  child: isSelected
                      ? Text(
                          navModel.itemTitle,
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(''))
            ],
          ),
        ),
      ));
    }

    return itemList;
  }
}
