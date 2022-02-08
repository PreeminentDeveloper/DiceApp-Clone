import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/event_bus/event_bus.dart';
import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/event_bus/events/online_event.dart';
import 'package:dice_app/core/network/url_config.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

final PhonixManager phonixManager = PhonixManager();

class PhonixManager {
  PhoenixSocket? phoenixSocket;
  PhoenixChannel? phoenixChannel;

  void initializePhonix() {
    phoenixSocket = PhoenixSocket(
        '${UrlConfig.phonixSocketBaseURL}${SessionManager.instance.authToken}&vsn=2.0.0')
      ..connect();

    phoenixSocket?.closeStream.listen((event) => {});

    phoenixSocket?.openStream.listen((event) {
      phoenixChannel = phoenixSocket?.addChannel(topic: "chat_room:lobby");

      phoenixChannel?.join();
      phoenixChannel?.messages.listen((event) {
        // if (event.event.value == 'single_presence_state') {
        //   eventBus.fire(OnlineListener(
        //       event.event.value, OnlineEvent.fromJson(event.payload!)));
        // }

        if (event.event.value.contains('create_message')) {
          eventBus.fire(ChatEventBus(
              event.event.value, ChatEventModel.fromJson(event.payload)));
        }
        if (event.event.value.contains('get_converstion_online_status')) {
          eventBus.fire(OnlineListener(event.event.value, event.payload!));
        }
      });
    });
  }
}
