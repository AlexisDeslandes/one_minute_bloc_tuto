import 'package:flutter/material.dart';
import 'package:one_minute_bloc_tuto/scrollable_reorderable_navbar/scrollable_reorderable_navbar.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _selectedIndex = 0;
  List<NavBarItem> _items = List.generate(
      10,
      (index) =>
          NavBarItem(widget: const Icon(Icons.group), name: "Item $index"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bottom nav bar")),
      body: Center(
        child: TextButton(
            onPressed: () {
              setState(() {
                _items.removeLast();
              });
            },
            child: const Text("Do something")),
      ),
      bottomNavigationBar: ScrollableReorderableNavBar(

        onItemTap: (arg) {
          setState(() {
            _selectedIndex = arg;
          });
        },
        onReorder: (oldIndex, newIndex) {
          final currItem = _items[_selectedIndex];
          if (oldIndex < newIndex) newIndex -= 1;
          final newItems = [..._items], item = newItems.removeAt(oldIndex);
          newItems.insert(newIndex, item);
          setState(() {
            _items = newItems;
            _selectedIndex = _items.indexOf(currItem);
          });
        },
        items: _items,
        selectedIndex: _selectedIndex,
        onDelete: (index) => setState(() => _items.removeAt(index)),
        deleteIndicationWidget: Container(
          padding: const EdgeInsets.only(bottom: 100),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                Text("Tap on nav item to delete it.",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center),
                TextButton(onPressed: () {}, child: const Text("DONE"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
