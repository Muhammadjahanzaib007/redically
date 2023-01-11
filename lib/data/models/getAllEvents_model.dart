
class EventsData {
  String? message;
  String? status;
  bool? isSuccess;
  int? errorCode;
  List<Event>? events;
  int? pageNumber;
  int? rowNumber;
  int? total;
  int? nextPage;

  EventsData(
      {this.message,
        this.status,
        this.isSuccess,
        this.errorCode,
        this.events,
        this.pageNumber,
        this.rowNumber,
        this.total,
        this.nextPage});

  EventsData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    isSuccess = json['isSuccess'];
    errorCode = json['errorCode'];
    if (json['payload'] != null) {
      events = <Event>[];
      json['payload'].forEach((v) {
        events!.add( Event.fromJson(v));
      });
    }
    pageNumber = json['pageNumber'];
    rowNumber = json['rowNumber'];
    total = json['total'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['isSuccess'] = this.isSuccess;
    data['errorCode'] = this.errorCode;
    if (this.events != null) {
      data['payload'] = this.events!.map((v) => v.toJson()).toList();
    }
    data['pageNumber'] = this.pageNumber;
    data['rowNumber'] = this.rowNumber;
    data['total'] = this.total;
    data['nextPage'] = this.nextPage;
    return data;
  }
}

class Event {
  int? id;
  String? eventName;
  String? eventImageUrl;
  String? eventDescription;
  String? eventStartDate;
  String? eventEndDate;

  Event(
      {this.id,
        this.eventName,
        this.eventImageUrl,
        this.eventDescription,
        this.eventStartDate,
        this.eventEndDate});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['eventName'];
    eventImageUrl = json['eventImageUrl'];
    eventDescription = json['eventDescription'];
    eventStartDate = json['eventStartDate'];
    eventEndDate = json['eventEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventName'] = this.eventName;
    data['eventImageUrl'] = this.eventImageUrl;
    data['eventDescription'] = this.eventDescription;
    data['eventStartDate'] = this.eventStartDate;
    data['eventEndDate'] = this.eventEndDate;
    return data;
  }
}