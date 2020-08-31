import 'package:logger/logger.dart';

var logger = Logger();

 void loggerGetX(String text, {bool isError = false}) {
logger.i('** ' + text + ' [' + isError.toString() + ']');
}