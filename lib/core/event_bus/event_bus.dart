import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class DashboardRouteEvent{
  int index;
  DashboardRouteEvent(this.index);
}

