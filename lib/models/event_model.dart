class Events {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  List<Event> _events = List.empty();
  List<Event> get events => _events;

  Events(
      {required totalSize, required typeId, required offset, required events}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._events = events;
  }

  Events.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['events'] != null) {
      _events = <Event>[];
      json['events'].forEach((v) {
        _events.add(Event.fromJson(v));
      });
    }
  }
}

// class Event {
//   int? id;
//   String? title;
//   String? description;
//   String? imageuri;

//   Event({this.id, this.title, this.description, this.imageuri});

//   Event.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     imageuri = json['imageuri'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['imageuri'] = this.imageuri;
//     return data;
//   }
// }

class Event {
  int? id;
  String? title;
  String? description;
  String? imageUri;
  String? date;
  String? location;
  String? time;

  Event(
      {this.id,
      this.title,
      this.description,
      this.imageUri,
      this.date,
      this.location,
      this.time});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imageUri = json['imageUri'];
    date = json['date'];
    location = json['location'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['imageUri'] = imageUri;
    data['date'] = date;
    data['location'] = location;
    data['time'] = time;
    return data;
  }
}
