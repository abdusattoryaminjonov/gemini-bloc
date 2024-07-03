import '../../data/datasources/local/nosql_service.dart';

class RootService{
  static Future<void> init() async {
    await NoSqlService.init();
  }
}