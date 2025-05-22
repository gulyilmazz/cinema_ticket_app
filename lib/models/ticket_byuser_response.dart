class TicketByUserResponse {
  bool? success;
  List<Ticket>? data;
  String? message;

  TicketByUserResponse({this.success, this.data, this.message});

  TicketByUserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Ticket>[];
      json['data'].forEach((v) {
        data!.add(Ticket.fromJson(v));
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

class Ticket {
  int? id;
  int? userId;
  int? showtimeId;
  String? seatNumber;
  String? price;
  String? status;
  String? ticketCode;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Showtime? showtime;

  Ticket({
    this.id,
    this.userId,
    this.showtimeId,
    this.seatNumber,
    this.price,
    this.status,
    this.ticketCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.showtime,
  });

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    showtimeId = json['showtime_id'];
    seatNumber = json['seat_number'];
    price = json['price'];
    status = json['status'];
    ticketCode = json['ticket_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    showtime =
        json['showtime'] != null ? Showtime.fromJson(json['showtime']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['showtime_id'] = showtimeId;
    data['seat_number'] = seatNumber;
    data['price'] = price;
    data['status'] = status;
    data['ticket_code'] = ticketCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (showtime != null) {
      data['showtime'] = showtime!.toJson();
    }
    return data;
  }
}

class Showtime {
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
  String? deletedAt;
  Movie? movie;
  CinemaHall? cinemaHall;

  Showtime({
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
    this.cinemaHall,
  });

  Showtime.fromJson(Map<String, dynamic> json) {
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
    cinemaHall =
        json['cinema_hall'] != null
            ? CinemaHall.fromJson(json['cinema_hall'])
            : null;
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
    if (cinemaHall != null) {
      data['cinema_hall'] = cinemaHall!.toJson();
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
  String? deletedAt;

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
    imdbRating = json['imdb_rating']?.toDouble();
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

class CinemaHall {
  int? id;
  int? cinemaId;
  String? name;
  int? capacity;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Cinema? cinema;

  CinemaHall({
    this.id,
    this.cinemaId,
    this.name,
    this.capacity,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.cinema,
  });

  CinemaHall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cinemaId = json['cinema_id'];
    name = json['name'];
    capacity = json['capacity'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    cinema = json['cinema'] != null ? Cinema.fromJson(json['cinema']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cinema_id'] = cinemaId;
    data['name'] = name;
    data['capacity'] = capacity;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (cinema != null) {
      data['cinema'] = cinema!.toJson();
    }
    return data;
  }
}

class Cinema {
  int? id;
  int? cityId;
  String? name;
  String? address;
  String? latitude;
  String? longitude;
  int? totalCapacity;
  String? phone;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Cinema({
    this.id,
    this.cityId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.totalCapacity,
    this.phone,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Cinema.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    totalCapacity = json['total_capacity'];
    phone = json['phone'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_id'] = cityId;
    data['name'] = name;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['total_capacity'] = totalCapacity;
    data['phone'] = phone;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
