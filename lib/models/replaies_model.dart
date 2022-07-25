import 'package:mimic/models/comment_class.dart';

import 'global_models/pegination_model.dart';

class ReplaiesModel {
  late final bool status;
  List<Replay> replaies = [];
  late final Links? links;
  ReplaiesModel(this.status, this.replaies, this.links);
  ReplaiesModel.fromJson(Map<String, dynamic> data) {
    status = data['status'];
    replaies =
        List.from(data['RP']['data']).map((e) => Replay.fromJson(e)).toList();
    links = Links.fromJson(data['RP']['links']);
  }
}
