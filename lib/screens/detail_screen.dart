import 'package:flutter/material.dart';
import 'package:medical/models/doctor_model.dart';

class DetailScreen extends StatefulWidget {
  final DoctorModel doctorData;
  
  const DetailScreen({super.key, required this.doctorData});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<CalendarModel> calendarData = [];
  List<TimeModel> timeData = [];

/* Se llava esta funcion para crear un widget con estado por primera vez */
  @override
  void initState() {
    super.initState();
    calendarData = widget.doctorData.calendar;
    timeData = widget.doctorData.time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 100,
        leadingWidth: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff050618).withOpacity(0.06),
                  blurRadius: 25,
                  offset: const Offset(0, 4)
                )
              ]
            ),
            child: const Icon(Icons.arrow_back),
          )
        ),
        title: const Text(
          "Detail Doctor",
          style: TextStyle(
            fontSize: 18
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoDoctor(),
            const SizedBox(height: 10,),
            _calendarDoctor(),
            const SizedBox(height: 10,),
            _timeDoctor(),
            const SizedBox(height: 80,),
            _bookButton(),
          ],       
        ),
      ),
    );
  }

  Widget _infoDoctor() {
/* Remplasamos el Container por el SizeBox porque no estamos usando sus propiedades */    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: Row(
            children: [
              Container( // Imagen
                width: 105,
                decoration: BoxDecoration(
                  color: widget.doctorData.imageBox,
                  borderRadius: BorderRadius.circular(16),
        /* Insertamos la imagen en el Container sin el child */                  
                  image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage(widget.doctorData.image)
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctorData.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16
                      ),
                    ),
                    Text(
                      widget.doctorData.specialties.first,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber[400],
                          size: 18,
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          widget.doctorData.score.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20,),
        const Text(
          "Biography",
          style: TextStyle(
            color: Color(0xff09121C),
            fontWeight: FontWeight.w300
          ),
        ),
        const SizedBox(height: 10,),
        Text(
          widget.doctorData.bio,
          style: const TextStyle(
            color: Color(0xff09121C),
            fontWeight: FontWeight.w300,
            fontSize: 12
          ),
        ),
        const SizedBox(height: 20,),
        const Text(
          'Specialities',
          style: TextStyle(
            color: Color(0xff09121C),
            fontWeight: FontWeight.w300
          ),
        ),
        const SizedBox(height: 10,),
        SizedBox(height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Text(
                widget.doctorData.specialties[index],
                style: const TextStyle(
                  color: Color(0xff09121C),
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  decoration: TextDecoration.underline
                ),
              );
            }, 
            separatorBuilder: (context, index) => const SizedBox(width: 20,), 
            itemCount: widget.doctorData.specialties.length
          ),
        )
      ],
    );
  }

  Widget _calendarDoctor() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calendar',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        ),
        const SizedBox(height: 10,),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  for (var item in calendarData) {
                    item.isSelected = false;
                  }
                  calendarData[index].isSelected = true;
                  setState(() {});
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: calendarData[index].isSelected 
                      ? const Color(0xff51A8FF)
                      : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 25,
                        color: calendarData[index].isSelected 
                          ? const Color(0xff51A8FF).withOpacity(0.45)
                          : const Color(0xff050618).withOpacity(0.05),
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      Text(
                        calendarData[index].dayNumber.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: calendarData[index].isSelected 
                            ? Colors.white
                            : Colors.black
                        ),
                      ),
                      Text(
                        calendarData[index].dayName,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          color: calendarData[index].isSelected 
                            ? Colors.white
                            : Colors.black
                        )
                      )
                    ],
                  ),
                ),
              );
            }, 
            separatorBuilder: (context, index) => const SizedBox(width: 50,), 
            itemCount: calendarData.length
          ),
        )
      ],
    );
  }


  Widget _timeDoctor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        ),
        const SizedBox(height: 10,),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  for (var item in timeData) {
                    item.isSelected = false;
                  }
                  timeData[index].isSelected = true;
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: timeData[index].isSelected 
                      ? const Color(0xff51A8FF) : Colors.white,
                    borderRadius: BorderRadius.circular(44),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 25,
                        color: timeData[index].isSelected 
                          ? const Color(0xff51A8FF).withOpacity(0.45)
                          : const Color(0xff050618).withOpacity(0.05)
                      )
                    ]
                  ),
                  child: Center(
                    child: Text(
                      timeData[index].time,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: timeData[index].isSelected
                          ? Colors.white : Colors.black
                      ),
                    ),
                  ),
                ),
              );
            }, 
            separatorBuilder: (context, index) => const SizedBox(width: 55,), 
            itemCount: timeData.length
          ),
        )
      ],
    );
  }

  Widget _bookButton() {
    return MaterialButton(
      onPressed: () {},
      height: 55,
      minWidth: double.infinity,
      elevation: 0,
      color: const Color(0xff51A8FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Text(
        'Book Appointmen',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
      ),
    );
  }

}