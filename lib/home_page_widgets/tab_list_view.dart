import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_newapp_web/datamodel/tabbardata.dart';
import 'tab_bar_items.dart';

int selectedIndex = 0;

class TabListView extends StatefulWidget {
  @override
  _TabListViewState createState() => _TabListViewState();
}

class _TabListViewState extends State<TabListView> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  void _goToElement(double index) {
    _scrollController.animateTo(
        (index), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 800),
        curve: Curves.ease);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabBarData>(builder: (context, data, child) {
      return Container(
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 10),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: data.tabIndexCount,
            itemBuilder: (context, index) {
              return TabBarItems(
                  tabBarModel: data.tabBarModel(index: index),
                  isSelected: index == data.currentTabIndex,
                  tabIndex: index,
                  changeTab: (tabIndex) {
                    setState(() {
                      data.setTabIndex(index: tabIndex);
                    });

                    if (selectedIndex > 2 && tabIndex == 2) {
                      _goToElement(-100);
                      selectedIndex = index;
                      return;
                    } else if (selectedIndex < 2 && tabIndex == 2) {
                      _goToElement(150);
                      selectedIndex = index;
                    } else if (selectedIndex >= 2 && tabIndex == 1) {
                      _goToElement(-50);
                      selectedIndex = index;
                    } else {
                      selectedIndex = index;
                    }
                  });
            },
          ),
        ),
      );
    });
  }
}
