class seansResponse {
  bool? success;
  List<SeansResponse>? data;
  String? message;

  seansResponse({this.success, this.data, this.message});

  seansResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SeansResponse>[];
      json['data'].forEach((v) {
        data!.add(new SeansResponse.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
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
    this.id,
    this.movieId,
    this.cinemaHallId,
    this.startTime,
    this.endTime,
    this.price,
    this.availableSeats,
    this.seatStatus,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.movie,
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
    movie = json['movie'] != null ? new Movie.fromJson(json['movie']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['movie_id'] = this.movieId;
    data['cinema_hall_id'] = this.cinemaHallId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['price'] = this.price;
    data['available_seats'] = this.availableSeats;
    data['seat_status'] = this.seatStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.movie != null) {
      data['movie'] = this.movie!.toJson();
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
  int? imdbRating;
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
    imdbRating = json['imdb_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['genre'] = this.genre;
    data['duration'] = this.duration;
    data['poster_url'] = this.posterUrl;
    data['language'] = this.language;
    data['release_date'] = this.releaseDate;
    data['is_in_theaters'] = this.isInTheaters;
    data['imdb_id'] = this.imdbId;
    data['imdb_rating'] = this.imdbRating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
