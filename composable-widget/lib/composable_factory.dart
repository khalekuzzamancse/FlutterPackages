import 'composable_widget.dart';
import 'navigation.dart';

class ComposableFactory {
  ComposableFactory._privateConstructor();

  static final ComposableFactory _instance = ComposableFactory._privateConstructor();

  static ComposableFactory get instance => _instance;

  ColumnBuilder column() => ColumnImpl();

  Row row2() => Row2Impl();

  FlowRow flowRow() => FlowRowImpl();

  Text text() => TextImpl();

  AsyncImage asyncImage() => AsyncImageImpl();

  BottomToNavRail bottomToNavRail() => BottomToNavRailImpl();

  Box box() => BoxImpl();
  CardBuilder card() =>CardImpl();

}
