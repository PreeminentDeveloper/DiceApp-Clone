// ignore_for_file: must_call_super

import 'package:dice_app/core/data/phonix_manager.dart';
import 'package:dice_app/core/event_bus/event_bus.dart';
import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  /// handles list of local messages from the database
  List<LocalChatModel>? localChats = [];

  /// controller for auto scrolling
  final ScrollController scrollController = ScrollController();

  /// Load messages fro local database
  void loadCachedMessages(String key, String userID) async {
    localChats = await chatDao!.convert(key);

    // auto scroll when done getting local messages
    _scrollDown();

    /// listen to chat events
    _listenToChatEvents(key, userID);

    /// notify listeners
    notifyListeners();
  }

  /// Adds message to local database
  void addMessageToLocalDB(LocalChatModel? localChatModel) {
    chatDao!.saveSingleChat(localChatModel!.conversationID!, localChatModel);

    /// cached messages
    loadCachedMessages(localChatModel.conversationID!, localChatModel.userID!);

    /// Send message to server
    _addMessageToLiveDB(localChatModel.conversationID, localChatModel.message);

    /// notify listeners
    notifyListeners();
  }

  /// sends message to the live server when there's network
  void _addMessageToLiveDB(String? conversationID, String? message) {
    try {
      final _push = phonixManager.phoenixChannel
          ?.push("create_message-$conversationID", {"message": message});
      if (_push!.sent) {
        logger.i('Message Sent: Update Ticker to sent icon');
      }
    } catch (e) {
      logger.e(e);
    }
  }

  /// Listens for when a message is been received
  ///
  /// when listening for chat event, if the UserID that is been returned is not equivalent to the senders UserID
  /// then the message should be cached locally
  _listenToChatEvents(String key, String userID) {
    eventBus.on().listen((event) {
      if (_isTargetMet(event, key, userID)) {
        Data _data = event.payload.data;
        chatDao!.saveSingleChat(
            key,
            LocalChatModel(
                conversationID: _data.message?.conversationId,
                id: _data.message?.id?.toString(),
                userID: _data.message?.userId,
                message: _data.message?.message,
                time: '',
                insertLocalTime: DateTime.now().toString()));
      }
    });
    // loadCachedMessages(key, userID);
  }

  ///Auto scroll chat to bottom of the list
  void _scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    notifyListeners();
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
}
