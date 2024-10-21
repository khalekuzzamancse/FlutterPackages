import 'package:flutter/material.dart';

// Custom NavigationItem class to hold label, icon, and optional selected icon.
class NavigationItem {
  final String label;
  final Icon icon;
  final Icon? selectedIcon;

  const NavigationItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
  });
}

/// Typically, the size and other properties of the navigation item need to be customized.
/// Therefore, we use an `Icon` instead of `IconData` to reduce the need for additional wrapping
/// in the consumer code.
///
/// Furthermore, the color of the navigation items should be consistent across all items,
/// using either the primary or secondary color,because it is clickable. To achieve this, you can pass the color
/// through different parameters or edit the code here.
///
/// Since this code is used in different projects, and an app usually has only one navigation decorator,
/// it is acceptable to edit the source code per project to avoid unnecessary methods and lengthy code.
abstract class BottomToNavRail {
  BottomToNavRail addItems(List<NavigationItem> items);

  BottomToNavRail addNavigationItem(NavigationItem item);

/// Typically, the size and other properties of the navigation item need to be customized.
/// Therefore, we use an `Icon` instead of `IconData` to reduce the need for additional wrapping
/// in the consumer code.
///
/// Furthermore, the color of the navigation items should be consistent across all items,
/// using either the primary or secondary color,because it is clickable. To achieve this, you can pass the color
/// through different parameters or edit the code here.
///
/// Since this code is used in different projects, and an app usually has only one navigation decorator,
/// it is acceptable to edit the source code per project to avoid unnecessary methods and lengthy code.
  BottomToNavRail addItem({
    required String label,
    required IconData icon,
    IconData? selectedIcon,
  });
    BottomToNavRail iconColor(Color color);

  BottomToNavRail appBar(AppBar? appBar);

  BottomToNavRail body(Widget body);

  BottomToNavRail floatingActionButton(FloatingActionButton? fab);

  BottomToNavRail selectedIndex(int index);

  BottomToNavRail onItemClicked(ValueChanged<int> callback);

  Widget build(BuildContext context);
}

// Implementation of the builder
class BottomToNavRailImpl implements BottomToNavRail {
  final List<NavigationItem> _navigationItems = [];
  AppBar? _appBar;
  Widget? _body;
  FloatingActionButton? _fab;
  int? _selectedIndex;
  ValueChanged<int>? _onItemClicked;
  Color? _iconColor;

  @override
  BottomToNavRailImpl addItems(List<NavigationItem> items) {
    _navigationItems.addAll(items);
    return this;
  }

  @override
  BottomToNavRailImpl addNavigationItem(NavigationItem item) {
    _navigationItems.add(item);
    return this;
  }

  @override
  BottomToNavRailImpl addItem({
    required String label,
    required IconData icon,
    IconData? selectedIcon,
  }) {
    _navigationItems.add(NavigationItem(
      label: label,
      icon: Icon(icon),
      selectedIcon: Icon(selectedIcon),
    ));
    return this;
  }
  @override
  BottomToNavRail iconColor(Color color) {
    _iconColor=color;
    return this;
  }

  @override
  BottomToNavRailImpl appBar(AppBar? appBar) {
    _appBar = appBar;
    return this;
  }

  @override
  BottomToNavRailImpl body(Widget body) {
    _body = body;
    return this;
  }

  @override
  BottomToNavRailImpl floatingActionButton(FloatingActionButton? fab) {
    _fab = fab;
    return this;
  }

  @override
  BottomToNavRailImpl selectedIndex(int index) {
    _selectedIndex = index;
    return this;
  }

  @override
  BottomToNavRailImpl onItemClicked(ValueChanged<int> callback) {
    _onItemClicked = callback;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    if (_navigationItems.isEmpty || _body == null || _selectedIndex == null) {
      throw Exception(
          "Navigation items, body, and selected index must be provided.");
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool useBottomNavigationBar = screenWidth < 600;

    return Scaffold(
      appBar: _appBar,
      body: Row(
        children: [
          if (!useBottomNavigationBar)
            NavigationRail(
              selectedIndex: _selectedIndex!,
              onDestinationSelected: _onItemClicked,
              labelType: NavigationRailLabelType.selected,
              destinations: _navigationItems.map((item) {
                return NavigationRailDestination(
                  icon:Icon( item.icon.icon,color: _iconColor!=null?_iconColor:Theme.of(context).primaryColor),
                  selectedIcon: item.selectedIcon ?? item.icon,
                  label: Text(item.label),
                );
              }).toList(),
            ),
          Expanded(
            child: _body!,
          ),
        ],
      ),
      bottomNavigationBar: useBottomNavigationBar
          ? NavigationBar(
              selectedIndex: _selectedIndex!,
              onDestinationSelected: _onItemClicked,
              indicatorColor: Colors.amber,
              destinations: _navigationItems.map((item) {
                return NavigationDestination(
                  icon: item.icon,
                  selectedIcon: item.selectedIcon ?? item.icon,
                  label: item.label,
                );
              }).toList(),
            )
          : null,
      floatingActionButton: _fab,
    );
  }


}

