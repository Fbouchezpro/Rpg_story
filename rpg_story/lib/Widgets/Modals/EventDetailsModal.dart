import 'package:flutter/material.dart';
import 'package:rpg_story/Models/Event.dart';
import 'package:rpg_story/Utils/Constants.dart';
import 'package:rpg_story/Utils/DateUtils.dart';
import 'package:rpg_story/Utils/EventsUtils.dart';

class EventDetailsModal extends StatelessWidget {
  final Event event;

  const EventDetailsModal({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      backgroundColor: BG_COLOR,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getCategoryImage(event.category)),
            fit: BoxFit.contain,
            opacity: 0.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GAP_H_8,
              Text(
                'Date & Time: ${displayDayMonth(date: event.date)}  ${displayBeautifulShortHour(
                  date: event.date,
                  use24HourFormat: true,
                )}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              GAP_H_8,
              Text(
                'Category: ${getCategoryString(event.category)}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              GAP_H_16,
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
