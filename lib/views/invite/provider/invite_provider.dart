import 'dart:io';

import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/auth/data/model/profile/profile_setup_model.dart';
import 'package:dice_app/views/home/data/source/remote.dart';
import 'package:dice_app/views/invite/model/contact/contacts_exists_response.dart';
import 'package:dice_app/views/invite/model/contact/contacts_model.dart';
import 'package:dice_app/views/invite/source/invite_remote.dart';
import 'package:flutter/material.dart';

enum InviteEnum { initial, busy, idle }

class InviteProvider extends ChangeNotifier {
  InviteEnum inviteEnum = InviteEnum.initial;
  final InviteService _inviteService;
  User? user;
  List<Contacts>? mContacts = [];
  List<dynamic> list = [];
  List searchUser = [];

  InviteProvider(this._inviteService);

  void checkIfConnections(List<String> contacts) async {
    try {
      inviteEnum = InviteEnum.busy;
      final _response = await _inviteService
          .checkIfContactsExists(ContactsModel(contacts: contacts));
      _response?.comparePhoneContactWithDiceContact?.map((compare) {
        mContacts = compare.contacts ?? [];
      }).toList();
    } catch (e) {
      inviteEnum = InviteEnum.idle;
    }
    notifyListeners();
  }


  void getConnections({required int pageNumber,
    int perPage = 20, required String? id}) async {
    try {
      inviteEnum = InviteEnum.busy;
      final _response = await _inviteService
          .getConnections(pageNumber: pageNumber,
          perPage: perPage,
          userID: id!);
      list = ((_response?.listConnections?.list ?? []) as List?)!;
      inviteEnum = InviteEnum.idle;
    } catch (e) {
      inviteEnum = InviteEnum.idle;
    }
    notifyListeners();
  }



  void findPeople({required String name}) async {
    try {
      inviteEnum = InviteEnum.busy;
      final _response = await _inviteService.findPeople(name: name);
      searchUser = (_response?.searchUser ?? []);
      print(searchUser);
      inviteEnum = InviteEnum.idle;
    } catch (e) {
      inviteEnum = InviteEnum.idle;
    }
    notifyListeners();
  }
}
