import 'dart:typed_data';

class Content {
  final int id;
  final int type;
  final int group_id;
  final String name;
  final Uint8List thumbnail;

  Content(this.id, this.type, this.group_id, this.name, this.thumbnail);
}
