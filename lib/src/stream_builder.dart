import 'package:rdart/rviews.dart';

final class StreamData<T> {
  StreamData();
  T? _data;

  bool _hasData = false;

  bool get hasData {
    return _hasData;
  }

  T? get data => _data;
  set data(T? data) {
    if (data != null) _hasData = true;
    _data = data;
  }
}

class StreamBuilder<T> extends Rview {
  final Stream<T> stream;
  final T? initialValue;
  //bool _isCompleted = false;
  final StreamData<T> futureData = StreamData();
  final Relement Function(StreamData<T> data) builder;
  Relement _relement = SizeBox();
  StreamBuilder(
      {required this.stream, required this.builder, this.initialValue});

  @override
  void initState() {
    //_isCompleted = false;

    _relement = builder.call(futureData);
    setState(
      () {},
    );
    stream.listen((event) {
      futureData.data = event;
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
