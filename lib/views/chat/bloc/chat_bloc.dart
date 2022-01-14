import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:dice_app/views/chat/data/sources/chat_sources.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

List<LocalChatModel> _localChats = [];

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _chatService;
  ChatBloc(this._chatService) : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ListChatEvent) {
      try {
        yield ChatLoadingState();
        final response = await _chatService.chatList(
            pageNo: event.pageIndex,
            userID: event.userID,
            conversationID: event.conversationID);
        response.listMessages?.list?.map((list) {
          _localChats.add(LocalChatModel(
              conversationID: "5aa9ba4a-6f55-4227-971d-bfae5f5d24a5",
              id: int.parse(list.id!),
              userID: list.user?.id,
              time: list.insertedAt,
              message: list.message));
        }).toList();
        yield ChatSuccessState(response: _localChats);
      } catch (e) {
        yield ChatFailedState(message: e.toString());
      }
    }
  }
}
