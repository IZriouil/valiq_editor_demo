import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 1,
    lineLength: 120,
    colors: true,
    noBoxingByDefault: true,
    printEmojis: true,
    printTime: true,
  ),
);
