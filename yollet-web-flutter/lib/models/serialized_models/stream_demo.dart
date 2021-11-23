import 'dart:async';
import 'dart:developer' as developer;

import 'package:yollet_web/UI/template/base/template.dart';

class StreamDemo extends StatelessWidget {
  const StreamDemo({Key? key}) : super(key: key);

  Stream<int> productsStream() async* {
    await Future.delayed(Duration(seconds: 2));
    List<int> numbers = [1, 2, 3, 4, 5, 6];
    for (int i = 0; i < numbers.length; i++) {
      yield numbers[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    StreamController<int> _controller = StreamController<int>();

    return Material(
      child: StreamBuilder(
          stream: _controller.stream,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            developer.log('Number: ' + snapshot.data.toString());
            return DefaultButton(
                text: snapshot.data.toString(),
                onPressed: () async {
                  await fetchStream();
                });
          }),
    );
  }

  fetchStream() async {
    String name = '20';
    var Surnamname = 'kom';

    var subject = StreamController();

    subject.add("I AM NEW");
    subject.add("I AM MED");
    subject.add("I AM OLD");
    subject.add(name);
    subject.add(Surnamname);

    subject.stream
        .map((element) => element)
        .listen((event) {})
        .onData((data) {});
  }
}
