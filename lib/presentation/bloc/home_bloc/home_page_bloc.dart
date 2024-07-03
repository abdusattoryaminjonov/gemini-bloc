import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gemini_bloc/presentation/bloc/home_bloc/home_page_event.dart';
import 'package:gemini_bloc/presentation/bloc/home_bloc/home_page_state.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/services/log_service.dart';
import '../../../core/services/utils_service.dart';
import '../../../data/datasources/local/nosql_service.dart';
import '../../../data/models/message_model.dart';
import '../../../data/repositories/gemini_talk_repository_impl.dart';
import '../../../domain/usecases/gemini_text_and_image_usecase.dart';
import '../../../domain/usecases/gemini_text_only_usecase.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<LoadHomeMessageEvent>(_onLoadHomeMessageEvent);
    on<HomeSelectedImageEvent>(_onSelectedImage);
    on<HomeRemoveImageEvent>(_onRemovedImage);
    on<HomeInitSTTEvent>(_initSTT);
    on<HomeStartSTTEvent>(_startSTT);
    on<HomeStopSTTEvent>(_stopSTT);
  }

  GeminiTextOnlyUseCase textOnlyUseCase =
  GeminiTextOnlyUseCase(GeminiTalkRepositoryImpl());
  GeminiTextAndImageUseCase textAndImageUseCase =
  GeminiTextAndImageUseCase(GeminiTalkRepositoryImpl());

  TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocusNode = FocusNode();

  String? pickedImage;

  List<MessageModel> messages = [];
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  FlutterTts flutterTts = FlutterTts();

  bool isLoading = false;


  Future<void> _onLoadHomeMessageEvent(LoadHomeMessageEvent event, Emitter<HomeState> emit) async {

    var data = NoSqlService.fetchNoSqlCard();
    messages = data;

    if (messages.isNotEmpty) {
      emit(HomeSuccessState(items: messages));
    } else {
      emit(HomeFailureState("No data"));
    }
  }

  apiTextOnly(String text) async {
    var either = await textOnlyUseCase.call(text);
    either.fold((l) {
      LogService.d(l);
      updateMessages(MessageModel(isMine: false, message: l),false);
    }, (r) async {
      LogService.d(r);
      updateMessages(MessageModel(isMine: false, message: r),false);
    });
  }

  apiTextAndImage(String text, String base64) async {
    var either = await textAndImageUseCase.call(text, base64);
    either.fold((l) {
      LogService.d(l);
      updateMessages(MessageModel(isMine: false, message: l),false);
    }, (r) async {
      LogService.d(r);
      updateMessages(MessageModel(isMine: false, message: r),false);
    });
  }

  updateMessages(MessageModel messageModel,bool isLoading) {
    this.isLoading = isLoading;
    messages.add(messageModel);
    emit(HomeSuccessState(items: messages));

    NoSqlService.saveNoSqlDB(messageModel);
  }


  onSendPressed(String text) async {
    if (pickedImage == null) {
      apiTextOnly(text);
      updateMessages(MessageModel(isMine: true, message: text),true);
    } else {
      apiTextAndImage(text, pickedImage!);
      updateMessages(
          MessageModel(isMine: true, message: text, base64: pickedImage),true);
    }
    textController.clear();
    emit(HomeRemoveImageState());
  }

  Future gotoIntranetPage(String url ,BuildContext context) async{
    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return  IntranetPage(url: url,);
    //     },
    //   ),
    // );
  }

  Future<void> _onSelectedImage(HomeSelectedImageEvent event ,Emitter<HomeState> emit) async {
    var base64 = await Utils.pickAndConvertImage();
    if (base64.trim().isNotEmpty) {
      pickedImage = base64;
      LogService.i(base64);
      emit(HomeSelectedImageState());
    }
  }

  Future _onRemovedImage(HomeRemoveImageEvent event, Emitter<HomeState> emit)async{
    pickedImage = null;
    emit(HomeRemoveImageState());
  }

  /// Speech to Text
  _initSTT(HomeInitSTTEvent event, Emitter<HomeState> emit) async {
    speechEnabled = await speechToText.initialize();
    emit(HomeInitSTTState());
  }

  _startSTT(HomeStartSTTEvent event, Emitter<HomeState> emit) async {
    await speechToText.listen(onResult: onSTTResult);
    emit(HomeStartSTTState());
  }

  void _stopSTT(HomeStopSTTEvent event, Emitter<HomeState> emit) async {
    await speechToText.stop();
    emit(HomeStopSTTState());
  }

  void onSTTResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      var words = result.recognizedWords;
      onSendPressed(words);
      LogService.i(words);
    }
  }

  Future speakTTS(String text) async{
    var result = await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future stopTTS() async{
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
}