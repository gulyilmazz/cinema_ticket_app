class MoviesResponse {
  bool? success;
  Movie? data;
  String? message;

  MoviesResponse({this.success, this.data, this.message});

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Movie.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Movie {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
  int? to;
  int? total;

  Movie({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (this.links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? genre;
  int? duration;
  String? posterUrl;
  String? language;
  String? releaseDate;
  bool? isInTheaters;
  String? imdbId;
  double? imdbRating;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  Data({
    id,
    title,
    description,
    genre,
    duration,
    posterUrl,
    language,
    releaseDate,
    isInTheaters,
    imdbId,
    imdbRating,
    createdAt,
    updatedAt,
    deletedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    genre = json['genre'];
    duration = json['duration'];
    posterUrl = json['poster_url'];
    language = json['language'];
    releaseDate = json['release_date'];
    isInTheaters = json['is_in_theaters'];
    imdbId = json['imdb_id'];
    imdbRating = json['imdb_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['genre'] = genre;
    data['duration'] = duration;
    data['poster_url'] = posterUrl;
    data['language'] = language;
    data['release_date'] = releaseDate;
    data['is_in_theaters'] = isInTheaters;
    data['imdb_id'] = imdbId;
    data['imdb_rating'] = imdbRating;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
