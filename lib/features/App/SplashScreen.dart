import 'package:flutter/material.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/features/Theme/AppThemeManager.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

class SplashScreen extends StatelessWidget with RenderAsyncSnapshot<bool>, BuildWithBuilder {
  final Widget child;
  final TransitionBuilder builder;

  const SplashScreen({Key key, this.builder, this.child}) : super(key: key);

  Future<bool> initializeApp() async {
    await PersistentStorage.initialize();
    await AppThemeManager.initialize();

    return true;
  }

  @override
  Widget build(BuildContext context) => buildFuture(initializeApp());

  Widget buildWaiting(BuildContext context) => DefaultRenders.buildWaiting(context);

  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  @override
  Widget buildData(BuildContext context, bool data) => buildWithBuilder(context, builder, child);
}
