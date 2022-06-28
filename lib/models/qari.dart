class Qari {
  String name;
  String path;
  String format;

  Qari({
    required this.name,
    required this.path,
    required this.format,
  });

  factory Qari.fromJSON(Map<String, dynamic> json) {
    return Qari(
      name: json['name'],
      path: json['relative_path'],
      format: json['file_formats'],
    );
  }
}
