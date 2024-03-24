class ApiData {
String api;
String description;
String auth;
String cors;
String link;
String category;
ApiData ({required this.api, required this.description, required this.auth, required this.cors, required this.link, required this.category});

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      api: json['API'] ?? '', 
      description: json['Description'] ?? '', 
      auth: json['Auth'] ?? '',
      cors: json['Cors'] ?? '', 
      link: json['Link'] ?? '', 
      category: json['Category'] ?? '', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'API': api,
      'Description': description,
      'Auth': auth,
      'Cors': cors,
      'Link': link,
      'Category': category,

    };
  }

}

