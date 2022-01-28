// ignore_for_file: must_call_super

import 'package:dice_app/core/data/phonix_manager.dart';
import 'package:dice_app/core/event_bus/event_bus.dart';
import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:dice_app/views/chat/data/models/sending_images.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ChatProvider extends ChangeNotifier {
  /// handles list of local messages from the database
  List<LocalChatModel>? localChats = [];

  /// Load messages fro local database
  void loadCachedMessages(String key) async {
    // await chatDao!.openBox(key: 'asdad');
  }

  /// sends message to the live server when there's network
  Future<void>? addMessageToLiveDB(
      String userID, String? conversationID, String? message) {
    try {
      final _push = phonixManager.phoenixChannel
          ?.push("create_message-$conversationID", {"message": message});
      if (_push!.sent) {
        logger.i('Message Sent: Update Ticker to sent icon');
        chatDao!.saveSingleChat(
            conversationID!,
            LocalChatModel(
                conversationID: conversationID,
                id: '',
                userID: userID,
                message: message,
                messageType: 'text',
                time: '',
                insertLocalTime: DateTime.now().toString()));
      }
    } catch (e) {
      logger.e(e);
    }
  }

  /// Listens for when a message is been received
  ///
  /// when listening for chat event, if the UserID that is been returned is not equivalent to the senders UserID
  /// then the message should be cached locally
  listenToChatEvents(String key, String userID) {
    eventBus.on<ChatEventBus>().listen((event) {
      Data _data = event.payload?.data ?? Data();

      if (_isTargetMet(event, key, userID)) {
        chatDao!.saveSingleChat(
            key,
            LocalChatModel(
                conversationID: _data.message?.conversationId,
                id: _data.message?.id?.toString(),
                userID: _data.message?.userId,
                messageType: _data.message!.medias != null &&
                        _data.message!.medias!.isNotEmpty
                    ? 'media'
                    : 'text',
                message: _data.message?.message,
                time: '',
                insertLocalTime: DateTime.now().toString(),
                imageSending: ImageSending(),
                messageFromEvent: _data.message));
      }
    });
  }

  /// clear list of the user
  @override
  void dispose() {
    localChats?.clear();
  }

  /// Returns true if the event type is a ChatEventBus,
  /// contains the chat conversation id and also the message is not from the sender
  bool _isTargetMet(event, key, userID) {
    return event is ChatEventBus &&
        event.key!.contains(key) &&
        event.payload?.data?.message?.userId != userID;
  }

  AssetType assetType = AssetType.image;

  void toggleMediaIcons(AssetType index) {
    assetType = index;
    notifyListeners();
  }
}
