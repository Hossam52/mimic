class Links {
  Links({
  //  required this.first,
    //required this.last,
    required this.next,
  });
 // late final String first;
  //late final String last;
  String? next;

  Links.fromJson(Map<String, dynamic> json) {
    //first = json['first'];
    //last = json['last'];
    next = json['next'];
  }
}
