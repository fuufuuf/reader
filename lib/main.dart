import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/App/common.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/features/App/ReaderApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  DefaultRenders.registerDefaultErrorBuilder(UserException.renderError);

  runApp(ReaderApp());
}
