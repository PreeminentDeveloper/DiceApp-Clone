// ignore_for_file: must_be_immutable

part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ListChatEvent extends ChatEvent {
  final int? pageIndex;
  final String? userID;
  final String? conversationID;
  ListChatEvent({this.pageIndex, this.userID, this.conversationID});
}
