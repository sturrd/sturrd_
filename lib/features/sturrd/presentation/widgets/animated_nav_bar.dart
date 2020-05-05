import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedNavBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onBarTap;

  AnimatedNavBar({
    @required this.barItems,
    this.animationDuration = const Duration(milliseconds: 500),
    this.onBarTap,
  });

  _AnimatedNavBarState createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar> with TickerProviderStateMixin {
  int selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          8.0,
          5.0,
          8.0,
          5.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildBarWidgets(),
        ),
      ),
    );
  }

//build widget for every barItem
  List<Widget> _buildBarWidgets() {
    //the initalized list of widgets
    List<Widget> barWidgets = [];
    for (int index = 0; index < widget.barItems.length; index++) {
      BarItem item = widget.barItems[index];
      bool isSelected = selectedBarIndex == index;

      Widget builtWidget = InkWell(
        splashColor: Colors.transparent, 
        onTap: () {
          setState(() {
            selectedBarIndex = index;
            //*method is called when an item is selected.Method is to display actual content
            //*with the selected bar index above the bottom navigation.
            widget.onBarTap(selectedBarIndex);
            print('called');
          });
        },
        //we are using a row beacuse we want to animate the text too.Buttons wont
        //give us access to animate the text.
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          duration: widget.animationDuration,
          //*Note the AnimatedContainer.
          decoration: BoxDecoration(
            color: isSelected
                ? item.color.withOpacity(0.1)
                :item.color.withOpacity(0.1), //*adding opacity to the item color if selected.
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            children: <Widget>[
           isSelected?   Icon(
                item.iconData,
                color: isSelected ? item.color : Colors.white,
              ): Container(),
              SizedBox(
                width:isSelected ?  10.0 : 0.0,
              ),                    
              //*Animates the size of the text widget.
              AnimatedSize(
                curve: Curves.easeInOut,
                duration: widget.animationDuration,
                vsync: this,
                child: Text(
                  item.text,
                  style: TextStyle(
                    color: item.color,
                  ),
                ),
              )
            ],
          ),
        ),
      );
      barWidgets.add(builtWidget);
    }
    return barWidgets;
  }
}

class BarItem {
  String text;
  IconData iconData;
  Color color;

  BarItem({this.text, this.iconData, this.color});
}

final List<BarItem> barItems = [
  BarItem(
    text: "All",
    iconData: FontAwesomeIcons.check,
    color: Colors.grey,
  ),
  BarItem(
    text: "Their",
    iconData: FontAwesomeIcons.check,
    color: Colors.grey,
  ),
  BarItem(
    text: "Your treat",
    iconData: FontAwesomeIcons.check,
    color: Colors.grey,
  ),
   BarItem(
    text: "50/50",
    iconData: FontAwesomeIcons.check,
    color: Colors.grey,
  ),
];
