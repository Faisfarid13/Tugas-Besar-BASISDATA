final String tableHistory = 'history';

class HistoryFields{
  static final List<String> values = [
    id, link
  ];

  static final String id = 'id';
  static final String link = 'link';
}

class History{
  final int? id;
  final String link;

  const History({
    this.id,
    required this.link,
  });

  History copy({
    final int? id,
    final String? link,
  })=>
      History(
        id: id ?? this.id,
        link: link ?? this.link,
      );

  static History fromJson(Map<String, Object?> json) => History(
    id: json[HistoryFields.id] as int?,
    link: json[HistoryFields.link] as String,
  );

  Map<String, Object?> toJson() =>{
    HistoryFields.id : id,
    HistoryFields.link : link,
  };
}