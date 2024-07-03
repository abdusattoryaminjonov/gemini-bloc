// import 'package:flutter/material.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:flutter_parsed_text/flutter_parsed_text.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../data/models/message_model.dart';
//
// Widget itemOfGeminiMessage(MessageModel message,BuildContext context){
//   return Container(
//     width: double.infinity,
//     padding: EdgeInsets.all(16),
//     margin: EdgeInsets.only(top: 15, bottom: 15),
//     child: Stack(
//       children: [
//         Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 30,
//                     child: Image.asset('assets/images/gemini_icon.png'),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       homeController.speakTTS(message.message!);
//                     },
//                     child: Icon(
//                       Icons.volume_up,
//                       color: Colors.white70,
//                     ),
//                   )
//                 ],
//               ),
//               // Container(
//               //   margin: EdgeInsets.only(top: 15),
//               //   child: Linkify(
//               //     onOpen: (link) => homeController.gotoIntranetPage(link.url,context),
//               //     text: message.message!,
//               //     style: TextStyle(
//               //         color: Color.fromRGBO(173, 173, 176, 1), fontSize: 16),
//               //   ),
//               // ),
//               Container(
//                   margin: EdgeInsets.only(top: 15),
//                   child: ParsedText(
//                     text:message.message!,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                     parse: <MatchText>[
//
//                       MatchText(
//                         type: ParsedType.URL,
//                         style: TextStyle(
//                           color: Colors.blue,
//                         ),
//                         onTap: (url) {
//                           homeController.gotoIntranetPage(url,context);
//                         },),
//                       MatchText(
//                         type: ParsedType.CUSTOM,
//                         pattern: r"``` .*? ```",
//                         style: TextStyle(
//                           color: Colors.white,
//                           backgroundColor: Colors.grey
//                         )
//                       )
//                     ],
//                   )
//               )
//             ],
//           ),
//         ),
//         homeController.isLoading ?  Container(
//           child: Lottie.asset('assets/lotties/gemini_loading1.json'),
//         ) : const SizedBox.shrink()
//       ],
//     ),
//   );
// }