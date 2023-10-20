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
  Future<T> future;
  T? initialValue;
  bool _isCompleted = false;
  FutureData<T>? data = FutureData();
  Relement Function(FutureData<T>? data) builder;
  Relement _relement = SizeBox();
  FutureBuilder(
      {required this.future, required this.builder, this.initialValue});

  @override
  void initState() {
    _isCompleted = false;

    _relement = builder.call(data);

    future.then((value) {
      data?.data = value;
      _relement = builder(data);
      _isCompleted = true;
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
