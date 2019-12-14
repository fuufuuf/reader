import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'book_models.dart';

part 'serializers.g.dart';

@SerializersFor(const [BookIndex])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();
