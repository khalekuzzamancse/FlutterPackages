import 'package:flutter/material.dart' as flutter;
import 'package:flutter/material.dart';

import 'modifier.dart';
//Put all in a single file so that easily can paste other projects

abstract class AsyncImage {
  AsyncImage link(String link);

  AsyncImage modifier(Modifier modifier);

  Widget build();
}

class AsyncImageImpl implements AsyncImage {
  String _link = "";
  Modifier _modifier = Modifier();

  @override
  AsyncImage link(String link) {
    _link = link;
    return this;
  }

  @override
  AsyncImage modifier(Modifier modifier) {
    _modifier = modifier;
    return this;
  }

  @override
  Widget build() {
    Widget rootLayout =
        Image.network(_link, fit: BoxFit.cover) //for keep image ratio same
            .modifier(_modifier);
    return rootLayout;
  }
}


abstract class Box {
  Box child({required Widget child, Modifier? modifier=null});
  Box modifier(Modifier modifier);
  Widget build();
}

class BoxImpl implements Box {
  Widget? _child;
  Modifier _modifier = Modifier();

  @override
  Box child({required Widget child, Modifier? modifier = null}) {
    // Apply the modifier to the child if provided
    _child = modifier != null ? child.modifier(modifier) : child;
    return this;
  }

  @override
  Box modifier(Modifier modifier) {
    _modifier = modifier;
    return this;
  }

  @override
  Widget build() {
    // Wrap the child with the modifier applied to the Box
    Widget box = _child ?? SizedBox.shrink();
    return box.modifier(_modifier);
  }
}

abstract class Button {
  Button label(String text);

  Button icon(IconData icon);

  Button onClick(VoidCallback onPressed);
  Button style(ButtonStyle style);
  Button asTextButton();
  Button asIconButton();

  Widget build();
}
class ButtonImpl implements Button {
  String? _text;
  IconData? _icon;
  VoidCallback? _onPressed;
  ButtonStyle? _style;
  Modifier _buttonModifier = Modifier();
  Modifier _iconModifier = Modifier();
  Modifier _labelModifier = Modifier();

  bool _asTextButton = false;
  bool _asIconButton = false;

  @override
  Button label(String text) {
    _text = text;
    return this;
  }

  @override
  Button icon(IconData icon) {
    _icon = icon;
    return this;
  }

  @override
  Button onClick(VoidCallback onPressed) {
    _onPressed = onPressed;
    return this;
  }
  @override
  Button style(ButtonStyle style) {
    _style = style;
    return this;
  }

  @override
  Button asTextButton() {
    _asTextButton = true;
    return this;
  }

  @override
  Button asIconButton() {
    _asIconButton = true;
    return this;
  }

  Button buttonModifier(Modifier modifier) {
    _buttonModifier = modifier;
    return this;
  }

  Button iconModifier(Modifier modifier) {
    _iconModifier = modifier;
    return this;
  }

  Button labelModifier(Modifier modifier) {
    _labelModifier = modifier;
    return this;
  }

  @override
  Widget build() {
    Widget? button;

    if (_asTextButton) {
      button = TextButton(
        onPressed: _onPressed,
        style: _style,
        child: _text != null
            ? flutter.Text(_text!).modifier(_labelModifier)
            : const SizedBox.shrink(),
      );
    } else if (_asIconButton) {
      button = IconButton(
        onPressed: _onPressed,
        icon: _icon != null
            ? Icon(_icon).modifier(_iconModifier)
            : const SizedBox.shrink(),
      );
    } else {
      button = ElevatedButton.icon(
        onPressed: _onPressed,
        icon: _icon != null
            ? Icon(_icon).modifier(_iconModifier)
            : const SizedBox.shrink(),
        label: _text != null
            ? flutter.Text(_text!).modifier(_labelModifier)
            : const SizedBox.shrink(),
        style: _style,
      );
    }

    // Apply the modifier to the button itself
    return button.modifier(_buttonModifier);
  }
}





abstract class ColumnBuilder {
  ColumnBuilder append({required Widget child,Modifier? modifier=null});

  ColumnBuilder spacer(double height);

  ColumnBuilder verticalArrangement(MainAxisAlignment mainAxisAlignment);

  ColumnBuilder horizontalAlignment(CrossAxisAlignment crossAxisAlignment);

  ColumnBuilder modifier(Modifier modifier); // New method to set the modifier

  Widget build();
}

class ColumnImpl implements ColumnBuilder {
  final List<Widget> _children = [];
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  MainAxisSize _mainAxisSize = MainAxisSize.max;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.center;
  TextDirection? _textDirection;
  VerticalDirection _verticalDirection = VerticalDirection.down;
  TextBaseline? _textBaseline;
  Modifier _modifier = Modifier(); // Field to store the modifier

  @override
  ColumnBuilder append({required Widget child,Modifier? modifier}) {
    Widget modifiedChild = modifier != null ? child.modifier(modifier) : child;
    _children.add(modifiedChild);
    return this;
  }

  @override
  ColumnBuilder spacer(double height) {
    _children.add(SizedBox(height: height));
    return this;
  }

  @override
  ColumnBuilder verticalArrangement(MainAxisAlignment mainAxisAlignment) {
    _mainAxisAlignment = mainAxisAlignment;
    return this;
  }

  @override
  ColumnBuilder horizontalAlignment(CrossAxisAlignment crossAxisAlignment) {
    _crossAxisAlignment = crossAxisAlignment;
    return this;
  }

  @override
  ColumnBuilder modifier(Modifier modifier) {
    _modifier = modifier;
    return this;
  }

  // Build method to construct the Column widget
  @override
  Widget build() {
    Widget rootLayout = flutter.Column(
      mainAxisAlignment: _mainAxisAlignment,
      mainAxisSize: _mainAxisSize,
      crossAxisAlignment: _crossAxisAlignment,
      textDirection: _textDirection,
      verticalDirection: _verticalDirection,
      textBaseline: _textBaseline,
      children: _children,
    );

    // Apply the modifier to the Column widget
    return rootLayout.modifier(_modifier);
  }
}


abstract class FlowRow {
  FlowRow append({required Widget child, Modifier modifier});

  FlowRow children(List<Widget> children);

  FlowRow spacer(double width);

  FlowRow horizontalSpacing(double spacing);

  FlowRow verticalSpacing(double spacing);

  FlowRow childAlign(WrapAlignment alignment); // New method for alignment

  FlowRow modifier(Modifier modifier);

  Widget build();
}

class FlowRowImpl implements FlowRow {
  final List<Widget> _children = [];
  double _horizontalSpacing = 0.0;
  double _verticalSpacing = 0.0;
  WrapAlignment _alignment = WrapAlignment.start; // Default alignment
  Modifier _modifier = Modifier();

  @override
  FlowRow append({required Widget child, Modifier? modifier = null}) {
    Widget modifiedChild = modifier != null ? child.modifier(modifier) : child;
    _children.add(modifiedChild);
    return this;
  }

  @override
  FlowRow children(List<Widget> children) {
    _children.addAll(children);
    return this;
  }

  @override
  FlowRow spacer(double width) {
    _children.add(SizedBox(width: width));
    return this;
  }

  @override
  FlowRow horizontalSpacing(double spacing) {
    _horizontalSpacing = spacing;
    return this;
  }

  @override
  FlowRow verticalSpacing(double spacing) {
    _verticalSpacing = spacing;
    return this;
  }

  @override
  FlowRow childAlign(WrapAlignment alignment) {
    _alignment = alignment;
    return this;
  }

  @override
  FlowRow modifier(Modifier modifier) {
    _modifier = modifier;
    return this;
  }

  @override
  Widget build() {
    // Create the Wrap widget with the given settings
    Widget flowRow = Wrap(
      spacing: _horizontalSpacing,
      runSpacing: _verticalSpacing,
      alignment: _alignment, // Apply the alignment
      children: _children,
    );

    // Apply the modifier to the entire Wrap widget
    return flowRow.modifier(_modifier);
  }
}



abstract class Row {
  Row append({required Widget child, Modifier modifier});

  Row spacer(double width);

  Row horizontalArrangement(MainAxisAlignment mainAxisAlignment);

  Row verticalAlignment(CrossAxisAlignment crossAxisAlignment);

  Row modifier(Modifier modifier); // New method to set the modifier for the row

  Widget build();
}

/// Implementation of Row2
class Row2Impl implements Row {
  final List<Widget> _children = [];
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.center;
  MainAxisSize _mainAxisSize = MainAxisSize.max;
  TextDirection? _textDirection;
  VerticalDirection _verticalDirection = VerticalDirection.down;
  TextBaseline? _textBaseline;
  Modifier _modifier = Modifier(); // Field to store the modifier for the row

  @override
  Row append({required Widget child, Modifier? modifier=null}) {
    Widget modifiedChild = modifier != null ? child.modifier(modifier) : child;
    _children.add(modifiedChild);
    return this;
  }

  @override
  Row spacer(double width) {
    _children.add(SizedBox(width: width));
    return this;
  }

  @override
  Row horizontalArrangement(MainAxisAlignment mainAxisAlignment) {
    _mainAxisAlignment = mainAxisAlignment;
    return this;
  }

  @override
  Row verticalAlignment(CrossAxisAlignment crossAxisAlignment) {
    _crossAxisAlignment = crossAxisAlignment;
    return this;
  }

  @override
  Row modifier(Modifier modifier) {
    _modifier = modifier;
    return this;
  }

  @override
  Widget build() {
    Widget row = flutter.Row(
      mainAxisAlignment: _mainAxisAlignment,
      mainAxisSize: _mainAxisSize,
      crossAxisAlignment: _crossAxisAlignment,
      textDirection: _textDirection,
      verticalDirection: _verticalDirection,
      textBaseline: _textBaseline,
      children: _children,
    );

    // Apply the modifier to the entire Row widget
    return row.modifier(_modifier);
  }
}

abstract class Text {
  Text text(String data);

  Text style(TextStyle? style);

  Text modifier(Modifier modifier);

  Widget build();
}

class TextImpl implements Text {
  Modifier _modifier = Modifier();
  Key? _key;
  String? _data;
  TextStyle? _style;
  StrutStyle? _strutStyle;

  @override
  Text text(String data) {
    _data = data;
    return this;
  }

  @override
  Text style(TextStyle? style) {
    _style = style;
    return this;
  }

  @override
  Text modifier(Modifier modifier) {
    _modifier = modifier;
    return this;
  }

  @override
  Widget build() {
    if (_data == null) {
      throw Exception('Text data is required');
    }
    return flutter.Text(
      _data!,
      key: _key,
      strutStyle: _strutStyle,
      style: _style,
    ).modifier(_modifier);
  }
}


abstract class Fab {
  Fab key(Key key);

  Fab icon(Widget child);

  Fab clickListener(VoidCallback onPressed);

  Fab tooltip(String tooltip);

  Fab background(Color color);

  Fab mini(bool mini);

  Fab shape(ShapeBorder shape);

  FloatingActionButton build();
}

class FabImpl implements Fab{
  Key? _key;
  Widget? _child;
  String? _tooltip;
  Color? _foregroundColor;
  Color? _backgroundColor;
  Color? _focusColor;
  Color? _hoverColor;
  Color? _splashColor;
  double? _elevation;
  double? _focusElevation;
  double? _hoverElevation;
  double? _highlightElevation;
  double? _disabledElevation;
  VoidCallback? _onPressed;
  MouseCursor? _mouseCursor;
  bool _mini = false;
  ShapeBorder? _shape;
  final Clip _clipBehavior = Clip.none;
  FocusNode? _focusNode;
  final bool _autoicous = false;
  MaterialTapTargetSize? _materialTapTargetSize;
  final bool _isExtended = false;
  bool? _enableFeedback;

  @override
  Fab key(Key key) {
    _key = key;
    return this;
  }
  @override
  Fab icon(Widget child) {
    _child = child;
    return this;
  }
  @override
  Fab clickListener(VoidCallback onPressed) {
    _onPressed = onPressed;
    return this;
  }
  @override
  Fab tooltip(String tooltip) {
    _tooltip = tooltip;
    return this;
  }
  @override
  Fab background(Color color) {
    _backgroundColor = color;
    return this;
  }

  // Continue adding methods for other properties...
  @override
  Fab mini(bool mini) {
    _mini = mini;
    return this;
  }
  @override
  Fab shape(ShapeBorder shape) {
    _shape = shape;
    return this;
  }

  // Build method to construct the FloatingActionButton
  @override
  FloatingActionButton build() {
    return FloatingActionButton(
      key: _key,
      tooltip: _tooltip,
      foregroundColor: _foregroundColor,
      backgroundColor: _backgroundColor,
      focusColor: _focusColor,
      hoverColor: _hoverColor,
      splashColor: _splashColor,
      elevation: _elevation,
      focusElevation: _focusElevation,
      hoverElevation: _hoverElevation,
      highlightElevation: _highlightElevation,
      disabledElevation: _disabledElevation,
      onPressed: _onPressed,
      mouseCursor: _mouseCursor,
      mini: _mini,
      shape: _shape,
      clipBehavior: _clipBehavior,
      focusNode: _focusNode,
      autofocus: _autoicous,
      materialTapTargetSize: _materialTapTargetSize,
      isExtended: _isExtended,
      enableFeedback: _enableFeedback,
      child: _child,
    );
  }
}


