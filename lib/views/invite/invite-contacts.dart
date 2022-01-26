import 'package:contacts_service/contacts_service.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/invite/provider/invite_provider.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'dao/contacts_dao.dart';
import 'widget/friends_invite_widget.dart';

class InviteContacts extends StatefulWidget {
  @override
  _InviteContactsState createState() => _InviteContactsState();
}

class _InviteContactsState extends State<InviteContacts> {
  Iterable<Contact> _contacts = [];
  List<String> phone = [];
  InviteProvider? _inviteProvider;

  @override
  void initState() {
    super.initState();
    _inviteProvider = Provider.of<InviteProvider>(context, listen: false);
    loadContacts();
  }

  loadContacts() async {
    // if (await PermissionManager.requestPermission(context)) {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    _contacts = contacts;
    await contactDao?.saveContacts(_contacts);
    for (var r in _contacts.toList()) {
      if (r.phones!.isNotEmpty) {
        phone.add(r.phones!.first.value!.replaceAll(' ', '').toString());
      }
    }
    // print(phone.map((val) => (val.toString())));
    // List<String> t = ["+23499990000127", "+23499990000124"];
    setState(() {});
    _inviteProvider?.checkIfConnections(phone);
    // }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: defaultAppBar(context, title: 'Invite', actions: [
          Container(
              margin: EdgeInsets.only(right: 16.w),
              child: SvgPicture.asset("assets/share.svg", height: 17))
        ]),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 13.h),
                    TextWidget(
                      text: "Send invites to friends to join Dice.",
                      type: "Objectivity",
                      weight: FontWeight.w700,
                      size: FontSize.s16,
                      appcolor: DColors.lightGrey,
                    ),
                    SizedBox(height: 13.h),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              width: 0.2,
                              color: Color(0XFF707070),
                              style: BorderStyle.solid)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<InviteProvider>(
                            builder: (context, invite, child) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 16.h),
                                  ...invite.mContacts!
                                      .map(
                                        (contacts) => FriendsInviteWidget(
                                          profilePic:
                                              'https://${contacts.user?.photo?.hostname}/${contacts.user?.photo?.url}',
                                          text: contacts.user?.name ?? '',
                                          subText:
                                              contacts.user?.username ?? '',
                                          buttonText: 'Add',
                                          onTap: () => {},
                                          // onTap: () => PageRouter.gotoWidget(
                                          //     OtherProfile(invitee?.requester?.id),
                                          //     context),
                                        ),
                                      )
                                      .toList()
                                ],
                              );
                            },
                          ),
                          ValueListenableBuilder(
                              valueListenable: contactDao!.getListenable()!,
                              builder: (_, Box<dynamic> box, __) {
                                final _cachedContacts =
                                    contactDao?.convert(box).toList();
                                if (_cachedContacts!.isEmpty) {
                                  return Container();
                                }
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomeDivider(),
                                    SizedBox(height: 16.h),
                                    ..._cachedContacts
                                        .map((contact) => FriendsInviteWidget(
                                            profilePic: '',
                                            text: contact.displayName ?? '',
                                            subText: "Send Invite",
                                            buttonText: 'Invite',
                                            onTap: () => Helpers.sendSMStoFriend(
                                                'Get this app and enjoy chatting like never before. dicemessenger.com',
                                                contact.phones?.first.value ??
                                                    '')))
                                        .toList()
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                  ]),
            )));
  }
}
