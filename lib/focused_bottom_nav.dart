library focused_bottom_nav;

import 'package:flutter/material.dart';

class FocusedBottomNav extends StatefulWidget {
  final List<BarItem> items;
  final ValueChanged<int> onTap;
  final int initialIndex;

  const FocusedBottomNav({
    Key key,
    @required this.items,
    @required this.onTap,
    this.initialIndex = 0,
  }) : super(key: key);
  @override
  _FocusedBottomNavState createState() => _FocusedBottomNavState();
}

class _FocusedBottomNavState extends State<FocusedBottomNav>
    with TickerProviderStateMixin {
  int index;
  @override
  void initState() {
    index = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Material(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildBarItems(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> _barItems = List();
    for (int i = 0; i < widget.items.length; i++) {
      final BarItem item = widget.items[i];
      bool isSelected = index == i;
      _barItems.add(
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => setState(() {
                widget.onTap(i);
                index = i;
              }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color:
                  isSelected ? item.color.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(8),
            child: AnimatedSize(
              duration: Duration(milliseconds: 200),
              vsync: this,
              curve: Curves.easeInOut,
              child: Row(
                children: <Widget>[
                  Icon(
                    item.iconData,
                    color: isSelected ? item.color : Colors.black,
                  ),
                  SizedBox(width: isSelected ? 4 : 0),
                  Text(
                    isSelected ? item.text : '',
                    style: TextStyle(
                      color: item.color,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return _barItems;
  }
}

class BarItem {
  final String text;
  final IconData iconData;
  final Color color;

  BarItem({@required this.text, @required this.iconData, @required this.color});
}
