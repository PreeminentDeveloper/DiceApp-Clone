// import 'package:dice_app/core/util/pallets.dart';
// import 'package:dice_app/core/util/size_config.dart';
// import 'package:dice_app/views/widgets/default_appbar.dart';
// import 'package:dice_app/views/widgets/grey_card.dart';
// import 'package:dice_app/views/widgets/textviews.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class AccountActions extends StatefulWidget {
//   @override
//   _AccountActionsState createState() => _AccountActionsState();
// }

// class _AccountActionsState extends State<AccountActions> {
//   var blocked, ignored;

//   var style = ButtonStyle(
//       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//         RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18.0),
//             side: BorderSide(color: DColors.primaryAccentColor)),
//       ),
//       padding: MaterialStateProperty.all<EdgeInsets>(
//           EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
//       minimumSize: MaterialStateProperty.all(Size(50.57, 21.17)));

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//         backgroundColor: DColors.white,
//         appBar: defaultAppBar(context, title: 'Account Actions'),
//         body: BlocProvider<SetUpBloc>(
//             create: (context) => setUpBloc,
//             child: BlocListener<SetUpBloc, SetUpState>(listener:
//                 (context, state) async {
//               if (state is SetUpError) {
//                 print(state.message);
//               }
//               // if(state is BlockedUserLoaded){
//               // }
//             }, child:
//                 BlocBuilder<SetUpBloc, SetUpState>(builder: (context, state) {
//               if (state is SetUpEmpty) {
//                 // return Center(child: CircularProgressIndicator());
//               }

//               if (state is BlockedUserLoaded) {
//                 blocked = state.blockedListEntity.blocked;
//                 // print(state.blockedListEntity.blocked);
//                 setUpBloc.add(ListIgnoredUsers(
//                     pageNo: 1, perPage: 10, search: "", userId: appState?.id));
//               }

//               if (state is IgnoredUserLoaded) {
//                 ignored = state.ignoredListEntity.ignoredUsers;
//               }

//               return (blocked != null && ignored != null)
//                   ? Container(
//                       child: Column(
//                         children: [
//                           GreyContainer(title: "Chats and Caches"),
//                           Container(
//                             margin: EdgeInsets.symmetric(horizontal: 16.w),
//                             child: Row(
//                               children: [
//                                 TextWidget(
//                                   text: "Cache",
//                                   weight: FontWeight.w500,
//                                   appcolor: Color(0xff333333),
//                                   size: FontSize.s16,
//                                   type: "Objectivity",
//                                 ),
//                                 SizedBox(width: SizeConfig.sizeXXL),
//                                 TextWidget(
//                                   text: "53.56MB",
//                                   type: "Objectivity",
//                                   size: FontSize.s14,
//                                   weight: FontWeight.w700,
//                                   appcolor: DColors.primaryColor,
//                                 ),
//                                 Spacer(),
//                                 TextButton(
//                                     onPressed: () {},
//                                     style: style,
//                                     child: TextWidget(
//                                       text: "Clear",
//                                       type: "Objectivity",
//                                       size: FontSize.s10,
//                                       weight: FontWeight.w700,
//                                       appcolor: DColors.primaryAccentColor,
//                                     ))
//                               ],
//                             ),
//                           ),
//                           _convo(),
//                           Container(
//                             margin: EdgeInsets.symmetric(horizontal: 16.w),
//                             child: Row(
//                               children: [
//                                 TextWidget(
//                                   text: "Ignored Accounts",
//                                   weight: FontWeight.w500,
//                                   appcolor: Color(0xff333333),
//                                   size: FontSize.s16,
//                                   type: "Objectivity",
//                                 ),
//                                 SizedBox(width: SizeConfig.sizeXXL),
//                                 TextWidget(
//                                   text: ignored.length.toString(),
//                                   type: "Objectivity",
//                                   size: FontSize.s14,
//                                   weight: FontWeight.w700,
//                                   appcolor: Colors.red,
//                                 ),
//                                 Spacer(),
//                                 TextButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (_) => IgnoredList(
//                                                   ignored: ignored,
//                                                   callback: () {
//                                                     setUpBloc.add(
//                                                         ListBlockedUsers(
//                                                             pageNo: 1,
//                                                             perPage: 10,
//                                                             search: "",
//                                                             userId:
//                                                                 appState?.id));
//                                                   })));
//                                     },
//                                     style: style,
//                                     child: TextWidget(
//                                       text: "view",
//                                       type: "Objectivity",
//                                       size: FontSize.s10,
//                                       weight: FontWeight.w700,
//                                       appcolor: DColors.primaryAccentColor,
//                                     ))
//                               ],
//                             ),
//                           ),
//                           GreyContainer(title: "Media and Auto-Download"),
//                         ],
//                       ),
//                     )
//                   : Center(child: CircularProgressIndicator());
//             }))));
//   }

//   _convo() {
//     return BlocProvider<HomeBloc>(
//         create: (context) => _homeBloc,
//         child:
//             BlocListener<HomeBloc, HomeState>(listener: (context, state) async {
//           if (state is HomeError) {
//             print(state.message);
//           }
//         }, child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
//           return Column(children: [
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Row(
//                 children: [
//                   TextWidget(
//                     text: "Conversations",
//                     weight: FontWeight.w500,
//                     appcolor: Color(0xff333333),
//                     size: FontSize.s16,
//                     type: "Objectivity",
//                   ),
//                   SizedBox(width: SizeConfig.sizeXXL),
//                   TextWidget(
//                     text: state is HomeLoaded
//                         ? state.homeEntity.conversationData.length.toString()
//                         : "",
//                     type: "Objectivity",
//                     size: FontSize.s14,
//                     weight: FontWeight.w700,
//                     appcolor: DColors.primaryColor,
//                   ),
//                   Spacer(),
//                   TextButton(
//                       onPressed: () {
//                         if (state is HomeLoaded)
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) => Conversation(
//                                       data:
//                                           state.homeEntity.conversationData)));
//                       },
//                       style: style,
//                       child: TextWidget(
//                         text: "View",
//                         type: "Objectivity",
//                         size: FontSize.s10,
//                         weight: FontWeight.w700,
//                         appcolor: DColors.primaryAccentColor,
//                       ))
//                 ],
//               ),
//             ),
//             GreyContainer(title: "Block list"),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Row(
//                 children: [
//                   TextWidget(
//                     text: "Blocked",
//                     weight: FontWeight.w500,
//                     appcolor: Color(0xff333333),
//                     size: FontSize.s16,
//                     type: "Objectivity",
//                   ),
//                   SizedBox(width: SizeConfig.sizeXXL),
//                   TextWidget(
//                     text: blocked.length.toString(),
//                     type: "Objectivity",
//                     size: FontSize.s14,
//                     weight: FontWeight.w700,
//                     appcolor: Colors.red,
//                   ),
//                   Spacer(),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => BlockedList(
//                                     blocked: blocked,
//                                     callback: () {
//                                       setUpBloc.add(ListBlockedUsers(
//                                           pageNo: 1,
//                                           perPage: 10,
//                                           search: "",
//                                           userId: appState?.id));
//                                     })));
//                       },
//                       style: style,
//                       child: TextWidget(
//                         text: "View",
//                         type: "Objectivity",
//                         size: FontSize.s10,
//                         weight: FontWeight.w700,
//                         appcolor: DColors.primaryAccentColor,
//                       ))
//                 ],
//               ),
//             ),
//           ]);
//         })));
//   }
// }
