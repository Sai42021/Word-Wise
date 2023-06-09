import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MeetingDataSource _events;
  late List<Appointment> _shiftCollection;
//creating a collection of calendar resource
  late List<CalendarResource> _employeeCalendarResource;
  late List<TimeRegion> _specialTimeRegions;

  @override
  void initState() {
    addResourceDetails();//method where we will define resourse _ 135
    addAppointments();
    addSpecialRegions();
    _events = MeetingDataSource(_shiftCollection, _employeeCalendarResource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Calendar'),
            ),
            body: SfCalendar(
                view: CalendarView.timelineWorkWeek,
                firstDayOfWeek: 1, //first day of the week is Monday
                timeSlotViewSettings: const TimeSlotViewSettings(
                    startHour: 9, endHour: 17), // Working hours for the day
                dataSource: _events,
                specialRegions: _specialTimeRegions)));
  }

  void addAppointments() {
    var subjectCollection = [
      'MAP Marks Consolidation',
      'NUST Vision 2030',
      'Project Planning',
      'SVV General Meeting',
      'Tech Support',
      'Development Meeting',
      'Scrum Meeting',
      'Exam Hall',
      'Supplementary Marks releases',
      'Performance Review'
      'Faculty meeting'
    ];

    var colorCollection = [
      const Color(0xFF0F8644),
      const Color(0xFF8B1FA9),
      const Color(0xFFD20100),
      const Color(0xFFFC571D),
      const Color(0xFF85461E),
      const Color(0xFF36B37B),
      const Color(0xFF3D4FB5),
      const Color(0xFFE47C73),
      const Color(0xFF636363)
    ];

    _shiftCollection =
    <Appointment>[]; //contains appointments to load in the calendar
    for (var calendarResource in _employeeCalendarResource) {
      var employeeIds = [calendarResource.id];

      for (int j = 0; j < 365; j++) {
        //sample appointments for 365 days
        for (int k = 0; k < 2; k++) {
          final DateTime date = DateTime.now().add(Duration(days: j + k));
          int startHour = 9 + Random().nextInt(6);
          startHour =
          startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
          final DateTime _shiftStartTime =
          DateTime(date.year, date.month, date.day, startHour, 0, 0);
          _shiftCollection.add(Appointment(
              startTime: _shiftStartTime,
              endTime: _shiftStartTime.add(const Duration(hours: 1)),
              subject: subjectCollection[Random().nextInt(8)],
              color: colorCollection[Random().nextInt(8)],
              startTimeZone: '',
              endTimeZone: '',
              resourceIds: employeeIds));
        }
      }
    }
  }

  void addResourceDetails() {//here we will define the string collection and names of employees
    var nameCollection = [
      'Xavier',
      'Mrs. Kays',
      'Erling',
      'Martin Odegaard',
      'Nate',
      'Theressia',
      'Mr.Chimba',
      'Mr. Simon',
      'James Bond',
      'Ibu',
      'Daniel',
      'Stephen Curry',
      'Bryan Cranston',
      'Johnson',
      'Emilson',
      'Maddison',
      'Allison',
      'Ederson',
      'Ruben',
      'Ruby'
    ];

    var userImages = [
      'images/Person1.jpg',
      'images/Person2.jpg',
      'images/Person3.jpg',
      'images/Person4.jpg',
      'images/Person5.jpg',
      'images/Person6.jpg',
      'images/Person7.jpg',
      'images/Person8.jpg',
      'images/Person9.jpg',
      'images/Person10.jpg',
      'images/Person11.jpg',
      'images/Person12.jpg',
      'images/Person13.jpg',
    ];

    _employeeCalendarResource = <CalendarResource>[];
    for (var i = 0; i < nameCollection.length; i++) {
      _employeeCalendarResource.add(CalendarResource(
          id: '000' + i.toString(),
          displayName: nameCollection[i],//displays a name from the list above
          color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
              Random().nextInt(255), 1),
          image:
          i < userImages.length ? ExactAssetImage(userImages[i]) : null));
    }
  }

  void addSpecialRegions() {
    final DateTime date = DateTime.now();
    _specialTimeRegions = [
      TimeRegion(
          startTime: DateTime(date.year, date.month, date.day, 13, 0, 0),
          endTime: DateTime(date.year, date.month, date.day, 14, 0, 0),
          text: 'Lunch',
          resourceIds: _employeeCalendarResource.map((e) => e.id).toList(),
          recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
          enablePointerInteraction: false)
    ];
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> shiftCollection,
      List<CalendarResource> employeeCalendarResource) {
    appointments = shiftCollection;
    resources = employeeCalendarResource;
  }
}
