import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../../core/constants/constants.dart';
import '../bloc/starter_bloc/starter_page_bloc.dart';
import 'home_page.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  late StarterPageBloc starterPageBloc;

  @override
  void initState() {
    super.initState();

    starterPageBloc = BlocProvider.of<StarterPageBloc>(context);
    starterPageBloc.initVideoPlayer();

    starterPageBloc.speakTTS(welcomingMessage);
  }

  @override
  void dispose() {
    starterPageBloc.videoPlayerController.dispose();
    starterPageBloc.stopTTS();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              Container(
                width: 120,
                child: Lottie.asset('assets/lotties/gemini_log.json'),

              ),
              Expanded(
                child: starterPageBloc.videoPlayerController.value.isInitialized
                    ? VideoPlayer(starterPageBloc.videoPlayerController)
                    : Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                       Navigator.pushReplacementNamed(context, HomePage.id);
                      // Navigator.push(context, PageTransition(
                      //   type: PageTransitionType.fade,
                      //     child: HomePage())
                      // );
                    },
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Chat with Gemini ',
                            style: TextStyle(color: Colors.grey[400], fontSize: 18),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}