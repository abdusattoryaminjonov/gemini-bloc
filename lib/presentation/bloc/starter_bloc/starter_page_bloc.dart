import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gemini_bloc/presentation/bloc/starter_bloc/starter_page_event.dart';
import 'package:gemini_bloc/presentation/bloc/starter_bloc/starter_page_state.dart';
import 'package:video_player/video_player.dart';

class StarterPageBloc extends Bloc<StarterPageEvent, StarterState> {
  StarterPageBloc() : super(StarterInitialState()) {
    on<StarterPageWaitEvent>(_onStarterPageWaitEvent);
  }

  late VideoPlayerController videoPlayerController;
  FlutterTts flutterTts = FlutterTts();

  Future<void> _onStarterPageWaitEvent(StarterPageWaitEvent event, Emitter<StarterState> emit) async {
    emit(StarterLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(StarterLoadedState());
  }

  callNextPage(BuildContext context){
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => BlocProvider(
    //           create: (context) => HomeBloc(),
    //           child: const HomePage(),
    //         )));
  }

  initVideoPlayer() {
    videoPlayerController =
    VideoPlayerController.asset("assets/videos/gemini_video.mp4")
      ..initialize().then((_) {
        emit(StarterVideoPlayState());
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
      });

  }

  stopVideoPlayer(){
    videoPlayerController.dispose();

  }

  Future speakTTS(String text) async {
    var result = await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future stopTTS() async {
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

}