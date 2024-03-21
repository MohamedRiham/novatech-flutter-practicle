class ApiData {
String api;
String description;
String auth;
String cors;
String link;
String category;
ApiData ({required this.api, required this.description, required this.auth, required this.cors, required this.link, required this.category});
  Map<String, dynamic> toMap() {
    return {
      'api': api,
      'description': description,
      'auth': auth,
      'cors': cors,
      'link': link,
      'category': category,

    };
  }



  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      api: json['api'] ?? '', 
      description: json['description'] ?? '', 
      auth: json['auth'] ?? '',
      cors: json['cors'] ?? '', 
      link: json['link'] ?? '', 
      category: json['category'] ?? '', 



    );
  }
}

