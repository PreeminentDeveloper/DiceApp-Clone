// ignore_for_file: must_call_super

import 'package:dice_app/core/data/phonix_manager.dart';
import 'package:dice_app/core/event_bus/event_bus.dart';
import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/views/chat/bloc/chat_bloc.dart';
import 'package:dice_app/views/chat/data/models/list_chat_response.dart';
import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:dice_app/views/chat/data/sources/chat_sources.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ChatProvider extends ChangeNotifier {
  /// handles list of local messages from the database
  List<LocalChatModel>? localChats = [];
  bool _isUserOnline = false;
  bool get isUserOnline => _isUserOnline;
  List<ListOfMessages> tempMessagesHolder = [];
  ChatService? _chatService;

  ChatProvider(this._chatService);

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
    final _bloc = ChatBloc(inject());

    eventBus.on<ChatEventBus>().listen((event) {
      Data _data = event.payload?.data ?? Data();
      _bloc.add(ListChatEvent(
          pageIndex: 1,
          userID: userID,
          conversationID: _data.message?.conversationId));
    });
  }
  
  AssetType assetType = AssetType.image;

  void toggleMediaIcons(AssetType index) {
    assetType = index;
    notifyListeners();
  }

  void removeSingleMessage(int messageid, String userId) async {
    try {
      await _chatService?.deleteMessage(messageid, userId);
    } catch (_) {
      logger.e(_);
    }
  }
}
