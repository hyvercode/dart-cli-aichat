import 'dart:async';
import 'dart:io';

class SpinnerService {
  bool _running = false;

  bool get isRunning => _running;

  void start() => _running = true;
  void stop() => _running = false;
}

Future<void> spinner(SpinnerService service) async {
  final frames = ['|', '/', '-', '\\'];
  int i = 0;
  while (service.isRunning) {
    stdout.write('\b${frames[i % frames.length]}');
    await Future.delayed(Duration(milliseconds: 100));
    i++;
  }

  stdout.write('\x1B[2K\r');
}
