import 'package:rdart/rviews.dart';

final class FutureData<T> {
  FutureData();
  T? _data;

  bool _hasData = false;

  bool get hasData {
    return _hasData;
  }

  set data(T? data) {
    if (data != null) _hasData = true;
    _data = data;
  }
}

class FutureBuilder<T> extends Rview {
  final Future<T> future;
  final T? initialValue;
  //bool _isCompleted = false;
  final FutureData<T> futureData = FutureData();
  final Relement Function(FutureData<T> data) builder;
  Relement _relement = SizeBox();
  FutureBuilder(
      {required this.future, required this.builder, this.initialValue});

  @override
  void initState() {
    //_isCompleted = false;

    _relement = builder.call(futureData);

    future.then((value) {
      futureData.data = value;
      _relement = builder(futureData);
      //_isCompleted = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Relement build() {
    return _relement;
    //_isCompleted ? _relement : SizeBox();
  }
}
