// import 'dart:io';

// import 'package:dice_app/core/navigation/page_router.dart';
// import 'package:dice_app/core/util/pallets.dart';
// import 'package:dice_app/views/widgets/default_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// import 'widget/texters_info_widget.dart';

// class ThirdPartyChatViewScreen extends StatefulWidget {
//   final data, id, conversationData;
//   ThirdPartyChatViewScreen({this.data, this.id, this.conversationData});

//   @override
//   _ThirdPartyChatViewScreenState createState() =>
//       _ThirdPartyChatViewScreenState();
// }

// class _ThirdPartyChatViewScreenState extends State<ThirdPartyChatViewScreen>
//     with TickerProviderStateMixin {
 
//   @override
//   void initState() {
//     _prepareAnimation();

//     super.initState();
//   }

//   loadMsg() async {


//   void _prepareAnimation() {
   
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: defaultAppBar(
//           context,
//           leading: IconButton(
//               onPressed: () => PageRouter.goBack(context),
//               icon: Icon(Icons.arrow_downward, color: DColors.primaryColor)),
//           titleSpacing: 0,
//           centerTitle: true,
//           titleWidget: _customAppBar(onTap: () {
//             setState(() => _animateValue = !_animateValue);
//             if (_animateValue) {
//               _controller.forward();
//             } else {
//               _controller.reverse();
//             }
//           }),
//         ),
//         body: GestureDetector(
//           onTap: () {
         
//           },
//           child: SafeArea(
//             child: Stack(
//               children: [
//                 BlocProvider<MessageBloc>(
//                     create: (context) => messageBloc,
//                     child: BlocListener<MessageBloc, MessageState>(
//                         listener: (context, state) async {
//                       if (state is MsgError) {}
//                     }, child: BlocBuilder<MessageBloc, MessageState>(
//                             builder: (context, state) {
//                       if (state is ListMsgLoaded) {
//                         msg = state.messageList;
//                       }
//                       return msg == null
//                           ? Center(child: CircularProgressIndicator())
//                           : NotificationListener<ScrollEndNotification>(
//                               onNotification: (scrollEnd) {
//                                 final metrics = scrollEnd.metrics;
//                                 if (metrics.atEdge) {
//                                   bool isTop = metrics.pixels == 0;
//                                   if (isTop) {
//                                     _paginate = false;
//                                   } else {
//                                     _paginate = true;
//                                     loadMsg();
//                                   }
//                                   setState(() {});
//                                 }
//                                 return true;
//                               },
//                               child: SingleChildScrollView(
//                                 key: PageStorageKey<String>('chat'),
//                                 child: Column(
//                                   children: [
//                                     SizedBox(height: 22.h),
//                                     Row(
//                                       children: [
//                                         Expanded(child: CustomeDivider()),
//                                         TextWidget(
//                                           text: 'Today',
//                                           type: "Circular",
//                                           size: FontSize.s12,
//                                           appcolor: DColors.lightGrey,
//                                         ),
//                                         Expanded(child: CustomeDivider()),
//                                       ],
//                                     ),
//                                     SizedBox(height: 22.h),
//                                     ...msg
//                                         .map((_message) =>
//                                             _message?.userData?.id ==
//                                                     appState?.id
//                                                 ? ReceiverSide(_message, () {})
//                                                 : SenderSide(_message, () {}))
//                                         .toList()
//                                         .reversed
//                                         .toList(),
//                                     SizedBox(height: 40.h)
//                                   ],
//                                 ),
//                               ),
//                             );
//                     }))),
//                 TextersInfoWidget(
//                     _animateValue, _animation, widget.conversationData),
//                 _getBottomStackedView(),
//               ],
//             ),
//           ),
//         ));
//   }

//   callAsyncFetch(res) async {
//     File image = await res.file; // image file
//     return image;
//   }

//   Stack _getBottomStackedView() => Stack(
//         children: [
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: SizeConfig.getDeviceWidth(context),
//               color: DColors.white,
//               padding: EdgeInsets.symmetric(vertical: 10.h),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextWidget(
//                         text: 'Dice View',
//                         appcolor: DColors.black,
//                         size: FontSize.s14,
//                         weight: FontWeight.bold,
//                       ),
//                       SizedBox(width: 5.w),
//                       SvgPicture.asset(
//                         Assets.eye,
//                         color: DColors.inputBorderColor,
//                         height: 15.h,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10.h),
//                   BlocProvider<HomeBloc>(
//                       create: (context) => homeBloc,
//                       child: BlocListener<HomeBloc, HomeState>(
//                           listener: (context, state) async {
//                         if (state is HomeError) {}
//                       }, child: BlocBuilder<HomeBloc, HomeState>(
//                               builder: (context, state) {
//                         return TextWidget(
//                           text: state is ConversationViewLoaded
//                               ? '${state.conversationViewerEntity.totalViewers.toString()} views | 0 active'
//                               : '0 views | 0 active',
//                           appcolor: DColors.black,
//                           size: FontSize.s14,
//                           weight: FontWeight.normal,
//                         );
//                       })))
//                 ],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: IconButton(
//                 padding: EdgeInsets.only(right: 38.w),
//                 onPressed: () => PageRouter.goBack(context),
//                 icon: Icon(Icons.arrow_downward)),
//           )
//         ],
//       );

//   /// [Note] Here, in other have  images centered appropriately, i had to duplicate the Row widget into 3 replica
//   /// Then i turned the left and the right replicate to visibility off so we can be left with the centered Replicate
//   // ** ✌️✌️✌️✌️ Hast Lavista Baby **/
//   GestureDetector _customAppBar({Function() onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 220.w,
//         alignment: Alignment.centerLeft,
//         // color: Colors.red,
//         child: TextersImagePreview(userInfo: widget.data),
//       ),

//       // Row(
//       //   children: [
//       //     Expanded(
//       //         flex: 1,
//       //         child: Visibility(visible: false, child: TextersImagePreview(userInfo: widget.data))),
//       //     Expanded(flex: 3, child: TextersImagePreview()),
//       //     Expanded(
//       //         flex: 3,
//       //         child: Visibility(visible: false, child: TextersImagePreview(userInfo: widget.data))),
//       //   ],
//       // ),
//     );
//   }
// }
