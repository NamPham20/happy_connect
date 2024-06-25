import 'dart:collection';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/event.dart';
import '../ultity/utils.dart';
import 'package:intl/intl.dart';

final showNoteProvider = StateProvider<bool>((ref) => false);
final calendarFormatProvider = StateProvider<CalendarFormat>((ref) {
  return CalendarFormat.month;
});


class HistoryCheckPage extends ConsumerStatefulWidget{
  const HistoryCheckPage({super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HistoryCheckPageState();
}

class HistoryCheckPageState  extends ConsumerState<HistoryCheckPage>{

  bool showNote = false;

  late final ValueNotifier<List<Event>> selectedEvent;
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be
  DateTime focusedDay = DateTime.now() ;
  DateTime? selectedDay;
  DateTime? rangeStart;
  DateTime? rangeEnd;
 

  @override
  void initState() {
    selectedDay = focusedDay;
    selectedEvent = ValueNotifier(_getEventsForDay(selectedDay!));
    super.initState();
  }

  @override
  void dispose() {
    selectedEvent.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selected, DateTime focused) {
    if (!isSameDay(selectedDay, selected)) {
      setState(() {
        selectedDay = selected;
        focusedDay = focused;
        rangeStart = null; // Important to clean those
        rangeEnd = null;
        rangeSelectionMode = RangeSelectionMode.enforced;
      });

      selectedEvent.value = _getEventsForDay(selected);
    }
  }

  @override
  Widget build(BuildContext context) {

    showNote = ref.watch(showNoteProvider);
    calendarFormat = ref.watch(calendarFormatProvider);
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: customAppbar(),
          body: Stack(
            children: [
              customCalendar(),
              customNotice()
            ]
          ),
        )
    );
  }

  AppBar customAppbar(){
    return AppBar(
      backgroundColor: Colors.red,
      title: const Text("Lịch sử chấm công"),
      titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 28,
            height: 28,
            child: IconButton(
                onPressed: (){
                  ref.read(showNoteProvider.notifier).state = !showNote;
                },
                style: IconButton.styleFrom(
                    backgroundColor: Colors.white
                ),
                icon: const Icon(Icons.question_mark_outlined, color: Colors.red,size: 12,)),
          ),
        )
      ],
    );
  }

  Widget customCalendar(){
    return  SizedBox(
      height:MediaQuery.of(context).size.height ,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width,
            child: TableCalendar<Event>(
              focusedDay: focusedDay,
              firstDay: kFirstDay,
              lastDay: kLastDay,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              rangeStartDay: rangeStart,
              rangeEndDay: rangeEnd,
              calendarFormat: calendarFormat,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: const CalendarStyle(outsideDaysVisible: false),
              onDaySelected: _onDaySelected,
              pageJumpingEnabled: true,
              onFormatChanged: (format){
                if(calendarFormat != format){
                  ref.read(calendarFormatProvider.notifier).state = format;
                }
              },
              onPageChanged: (focused){
                focusedDay= focused;
              },
              calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
                if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
                  final text = DateFormat.E().format(day);
                  return Center(
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return null;
              },
                defaultBuilder: (context, day, focusedDay) {
                  if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
                    return Center(
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return null;
                },
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    int length = events.length<=2 ? events.length: 2;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for(int i=0; i<length;i++)
                          Container(
                            width : 10,
                            height: 10,
                            margin: const EdgeInsets.only(left: 2),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blueAccent
                            ),)
                      ],
                    );
                  }else {
                    return null;
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 12,),
          Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: selectedEvent,
                builder: (BuildContext context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value[index].title),
                          ),
                        );
                      }
                  );
                },

              )
          )


        ],
      ),
    );
  }

  Widget customNotice() {
    return  Entry.offset(
      visible: showNote,
      child: GestureDetector(
        onTap: (){
          ref.read(showNoteProvider.notifier).state = !showNote;
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.withOpacity(0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Ghi chú",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.task_alt_rounded,color: Colors.white,),
                        ),
                        Text("  : Chấm công thành công"),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.cancel_outlined,color: Colors.white,),
                        ),
                        Text("  : Chấm công Không thành công"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person_add_alt_1,color: Colors.green,size: 40,),
                        Text("  : Chấm công thủ công thành công"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person_remove_alt_1,color: Colors.red,size: 40,),
                        Text("  : Chấm công thủ công không thành công"),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
          ),
        ),
      ),
    );
  }
}