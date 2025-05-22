class SeansListResponse {
  bool? success;
  List<SeansResponse>? data;
  String? message;

  SeansListResponse({this.success, this.data, this.message});

  SeansListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SeansResponse>[];
      json['data'].forEach((v) {
        data!.add(SeansResponse.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class SeansResponse {
  int? id;
  int? movieId;
  int? cinemaHallId;
  String? startTime;
  String? endTime;
  String? price;
  int? availableSeats;
  String? seatStatus;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  Movie? movie;

  SeansResponse({
    id,
    movieId,
    cinemaHallId,
    startTime,
    endTime,
    price,
    availableSeats,
    seatStatus,
    createdAt,
    updatedAt,
    deletedAt,
    movie,
  });

  SeansResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    movieId = json['movie_id'];
    cinemaHallId = json['cinema_hall_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    price = json['price'];
    availableSeats = json['available_seats'];
    seatStatus = json['seat_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    movie = json['movie'] != null ? Movie.fromJson(json['movie']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['movie_id'] = movieId;
    data['cinema_hall_id'] = cinemaHallId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['price'] = price;
    data['available_seats'] = availableSeats;
    data['seat_status'] = seatStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (movie != null) {
      data['movie'] = movie!.toJson();
    }
    return data;
  }
}

class Movie {
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

  Movie({
    this.id,
    this.title,
    this.description,
    this.genre,
    this.duration,
    this.posterUrl,
    this.language,
    this.releaseDate,
    this.isInTheaters,
    this.imdbId,
    this.imdbRating,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Movie.fromJson(Map<String, dynamic> json) {
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
    imdbRating =
        (json['imdb_rating'] is int)
            ? (json['imdb_rating'] as int).toDouble()
            : json['imdb_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
