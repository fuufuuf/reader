import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/BookIndex.dart';

part 'serializers.g.dart';

@SerializersFor(const [BookEntry, BookIndex])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();

