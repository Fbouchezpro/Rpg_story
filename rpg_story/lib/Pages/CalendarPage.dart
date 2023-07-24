import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_story/Bloc/Event_bloc/event_bloc.dart';
import 'package:rpg_story/Models/Event.dart';
import 'package:rpg_story/Utils/Constants.dart';
import 'package:rpg_story/Utils/DateUtils.dart';
import 'package:rpg_story/Utils/EventsUtils.dart';
import 'package:rpg_story/Widgets/CustomLoadingWidget.dart';
import 'package:rpg_story/Widgets/CustomSnackBar.dart';
import 'package:rpg_story/Widgets/Modals/EventDetailsModal.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final List<Event> _events = <Event>[];
  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventBlocBloc>(context).add(RequestingListEvents());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<EventBlocBloc, EventBlocState>(
        listener: (context, listener) {
          if (listener is ListEventsDone) {
            setState(() {
              _events.clear();
              _events.addAll(listener.listEvents);
            });
          }
        },
        builder: (context, state) {
          if (state is ListEventsLoading) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CustomLoadingWidget(),
                  GAP_H_16,
                  Text('Loading you\'re next events...')
                ],
              ),
            );
          } else if (state is ListEventsFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('Failed to fetch events'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<EventBlocBloc>(context)
                        .add(RequestingListEvents());
                  },
                  child: const Text('Retry'),
                ),
              ],
            );
          }
          return SafeArea(
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: PRIMARY_COLOR,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonShowsNext: false,
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                GAP_H_16,
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Events for  ${displayDayMonth(date: _selectedDay)}:',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                GAP_H_8,
                Expanded(
                  child: ListView(
                    children: _getEventsForDay(_selectedDay)
                        .map(
                          (event) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shadowColor: PRIMARY_COLOR,
                              elevation: 15,
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EventDetailsModal(event: event);
                                    },
                                  );
                                },
                                title: Text(
                                  event.title,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                subtitle: Text(displayBeautifulShortHour(
                                        date: event.date, use24HourFormat: true)
                                    .toString()),
                                trailing: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image(
                                      image: AssetImage(
                                    getCategoryImage(event.category),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addEvent',
        onPressed: (() {
          _showAddNewEvent(context);
        }),
        tooltip: "add a new event",
        mini: true,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events.where((event) => isSameDay(event.date, day)).toList();
  }

  void _showAddNewEvent(BuildContext context) async {
    final DateTime now = DateTime.now();
    if (_selectedDay.isBefore(now)) {
      _selectedDay = now;
    }

    final pickedDateTime = await showDatePicker(
      context: context,
      initialDate: _selectedDay,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDateTime != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final pickedDateTimeWithTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            String eventName = '';
            String selectedCategoryLabel = '';
            EventCategory? selectedCategory;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Add Event'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          eventName = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter event name',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Date & Time: ${displayDayMonth(date: pickedDateTimeWithTime)}  ${displayBeautifulShortHour(
                          date: pickedDateTimeWithTime,
                          use24HourFormat: true,
                        )}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      DropdownButton<EventCategory>(
                        value: selectedCategory,
                        onChanged: (EventCategory? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                            selectedCategoryLabel =
                                getCategoryString(newValue!);
                          });
                        },
                        items: [
                          const DropdownMenuItem<EventCategory>(
                            value: null,
                            child: Text('Select Category'),
                          ),
                          ...EventCategory.values.map((EventCategory category) {
                            return DropdownMenuItem<EventCategory>(
                              value: category,
                              child: Text(getCategoryString(category)),
                            );
                          }).toList(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Selected Category: $selectedCategoryLabel',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (eventName.isNotEmpty && selectedCategory != null) {
                          final newEvent = CreateEvent(
                            id: uuid.v4().toString(),
                            title: eventName,
                            date: pickedDateTimeWithTime,
                            category: selectedCategory!,
                          );
                          BlocProvider.of<EventBlocBloc>(context).add(newEvent);
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
        );
      }
    }
  }
}
