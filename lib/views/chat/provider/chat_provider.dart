// ignore_for_file: must_call_super

import 'package:dice_app/core/data/phonix_manager.dart';
import 'package:dice_app/core/event_bus/event_bus.dart';
import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/chat/data/models/list_chat_response.dart';
import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ChatProvider extends ChangeNotifier {
  /// handles list of local messages from the database
  List<LocalChatModel>? localChats = [];
  bool _isUserOnline = false;
  bool get isUserOnline => _isUserOnline;
  List<ListOfMessages> tempMessagesHolder = [];

  @override
  void dispose() {
    localChats = [];
    tempMessagesHolder = [];
    _isUserOnline = false;
    localChats?.clear();

    super.dispose();
  }

  /// Load messages fro local database
  void loadMessagesFromServer(String key) async {
    try {
      final _response = chatDao!.convert(chatDao!.box!).toList();
      tempMessagesHolder = _response;
    } catch (e) {}
  }

  /// mark all messages as read
  Future<void>? markAllMessageAsRead(String? conversationID) {
    try {
      final _push = phonixManager.phoenixChannel
          ?.push("mark_all_unread_chats-$conversationID", {});
      if (_push!.sent) {
        logger.i(
            'Mark All Message Read: ${_push.sent}:  ConversationID === $conversationID');
      }
      final _isOnline = phonixManager.phoenixChannel
          ?.push("get_converstion_online_status-$conversationID", {});
      if (_isOnline!.sent) {
        logger.i('Checking if a user is online: $_isOnline');
      }
    } catch (e) {
      logger.e(e);
    }
  }

  /// sends message to the live server when there's network
  Future<bool>? addMessageToLiveDB(
      String userID, String? conversationID, String? message) async {
    try {
      final _push = await phonixManager.phoenixChannel
          ?.push("create_message-$conversationID", {"message": message});
      if (_push!.sent) logger.i('Message Sent: Update Ticker to sent icon');
      return _push.sent;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  /// Listens for when a message is been received
  /// when listening for chat event, if the UserID that is been returned is not equivalent to the senders UserID
  /// then the message should be cached locally
  listenToChatEvents(String key, String userID, String receiverID) {
    eventBus.on<ChatEventBus>().listen((event) {
      Data _data = event.payload?.data ?? Data();
      logger.d(_data.toJson());
      chatDao!.saveSingleChat(
          key,
          ListOfMessages(
              insertedAt: _data.message?.insertedAt,
              id: _data.message?.id.toString(),
              user: User(id: _data.message?.userId),
              medias: _data.message?.medias));
    });
  }

  /// Handles when a user joins a conversation
  void _handleWhenUserJoins(List list, String? receipientID) {
    list.map((e) {
      if (e['id'] == receipientID) {
        _isUserOnline = true;
        notifyListeners();
      }
    }).toList();
    logger.i('$receipientID Joins the conversations: $_isUserOnline');
  }

  /// Handles when a user leaves a conversation
  void _handleWhenUserLeaves(List list, String? receipientID) {
    list.map((e) {
      if (e['id'] == receipientID) {
        _isUserOnline = false;
        notifyListeners();
      }
    }).toList();
    logger.i('$receipientID Leaves the conversations: $_isUserOnline');
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
