// ignore_for_file: must_be_immutable

part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatSuccessState extends ChatState {
  dynamic response;
  ChatSuccessState({required this.response});
}

class ChatFailedState extends ChatState {
  String message;
  ChatFailedState({required this.message});
}
