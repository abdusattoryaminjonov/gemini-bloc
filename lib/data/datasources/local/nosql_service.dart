import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/message_model.dart';

class NoSqlService {
  static var box = Hive.box('my_nosql');

  static Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDirectory.path)
      ..registerAdapter(MessageModelAdapter());
    await Hive.openBox("my_nosql");
  }

  /// Save object without
  static saveNoSqlDB(MessageModel messageModel) async {
     await box.add(messageModel);
  }

  static List<MessageModel> fetchNoSqlCard() {
    List<MessageModel> message = [];
    for (int i = 0; i < box.length; i++) {
      var card = box.getAt(i);
      message.add(card);
    }
    return message;
  }

  // static updateNoSqlCard(int index,MessageModel noSql) async {
  //   box.putAt(index, noSql);
  // }
  //
  // static deleteNoSqlCardByIndex(int index) async {
  //   box.deleteAt(index);
  // }
}