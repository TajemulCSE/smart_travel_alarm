import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmListWidget extends StatefulWidget {
  const AlarmListWidget({super.key});

  @override
  State<AlarmListWidget> createState() => _AlarmListWidgetState();
}

class _AlarmListWidgetState extends State<AlarmListWidget> {
  List<Map<String, dynamic>> alarms = [
    {'time': '7:10 pm', 'date': 'Fri 21 Mar 2025', 'enabled': true},
    {'time': '6:55 pm', 'date': 'Fri 21 Mar 2025', 'enabled': false},
    
  ];

  Future<void> _pickDateTime() async {
    DateTime now = DateTime.now();

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: ThemeData.dark(),
        child: child!,
      ),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData.dark(),
        child: child!,
      ),
    );

    if (time == null) return;

    final DateTime finalDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final formattedTime = DateFormat.jm().format(finalDateTime);
    final formattedDate = DateFormat('EEE d MMM yyyy').format(finalDateTime);

    setState(() {
      alarms.add({
        'time': formattedTime,
        'date': formattedDate,
        'enabled': true,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: alarms.length,
          itemBuilder: (context, index) {
            final alarm = alarms[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1B0F39),
                borderRadius: BorderRadius.circular(89),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Time and Date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alarm['time'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'popins',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 65),
                      Text(
                        alarm['date'],
                        style: TextStyle(
                          color: Colors.white54,
                          fontFamily: 'popins',
                          
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  // Switch
                  Switch(
                    value: alarm['enabled'],
                    onChanged: (value) {
                      setState(() {
                        alarms[index]['enabled'] = value;
                      });
                    },
                    
                    activeTrackColor: Color(0xFF5200FF),
                    inactiveThumbColor: Colors.black,
                    inactiveTrackColor: Colors.white,
                  ),
                ],
              ),
            );
          },
        ),

        // Floating Action Button
        Positioned(
          bottom: 60,
          right: 20,
          child: SizedBox(
            height: 66,
            width: 66,
            child: FloatingActionButton(
              
              elevation: 0,shape: CircleBorder(),
              backgroundColor: Color(0xFF5200FF),
              onPressed: _pickDateTime,
              child: const Icon(Icons.add, color: Colors.white),
              
            ),
          ),
        ),
      ],
    );
  }
}
