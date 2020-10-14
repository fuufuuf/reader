import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/App/UserException.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/features/App/ReaderApp.dart';
import 'package:timnew_reader/repositories/settings/BookIndexRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await BookIndexRepository.init();

  DefaultRenders.registerDefaultErrorBuilder(UserException.renderError);

  runApp(ReaderApp());
}
