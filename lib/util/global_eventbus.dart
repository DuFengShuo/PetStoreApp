import 'package:event_bus/event_bus.dart';

typedef void EventCallback(arg);

class GlobalEventBus {
  EventBus event;
  factory GlobalEventBus() => _getInstances();
  static GlobalEventBus get instance => _getInstances();
  static GlobalEventBus _instances;
  GlobalEventBus._internal() {
    event = EventBus();
  }
  static GlobalEventBus _getInstances() {
    if (_instances == null) {
      _instances = GlobalEventBus._internal();
    }
    return _instances;
  }
}
