import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/event_bus/event_bus.dart';
import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/event_bus/events/online_event.dart';
import 'package:dice_app/core/network/url_config.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/chat/bloc/chat_bloc.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

final PhonixManager phonixManager = PhonixManager();

class PhonixManager {
  PhoenixSocket? phoenixSocket;
  PhoenixChannel? phoenixChannel;

  void initializePhonix() {
    phoenixSocket = PhoenixSocket(
        '${UrlConfig.phonixSocketBaseURL}${SessionManager.instance.authToken}&vsn=2.0.0')
      ..connect();

    phoenixSocket?.closeStream
        .listen((event) => logger.d('Closing _phoenix => $event'));

    phoenixSocket?.openStream.listen((event) {
      phoenixChannel = phoenixSocket?.addChannel(topic: "chat_room:lobby");

      phoenixChannel?.join();
      phoenixChannel?.messages.listen((event) {
        // presence_state
        if (event.event.value == 'presence_diff') {
          eventBus.fire(event.payload);
        }
        // if (event.event.value.contains(event.event.value)) {
        //   eventBus.fire(ChatEventBus(
        //       event.event.value, ChatEventModel.fromJson(event.payload)));
        // }
      });
    });
  }
}
