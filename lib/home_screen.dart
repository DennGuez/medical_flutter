import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/models/category_model.dart';
import 'package:medical/models/doctor_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CategoryModel> categoriesData = CategoryModel.getCategories();
  final List<DoctorModel> doctorsData = DoctorModel.getDoctors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          _categories()
        ],
      ),
    );
  }

  Column _categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
          child: Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 23
            ),
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.all(20),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  for (var item in categoriesData) {
                    item.isSelected = false;
                  }  
                  categoriesData[index].isSelected = true;
                  setState((){});
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: categoriesData[index].isSelected
                        ? const Color(0xff51A8FF).withOpacity(0.45)
                        : const Color(0xff050618).withOpacity(0.05),
                        offset: const Offset(0, 4),
                        blurRadius: 25
                      )
                    ],
                    color: categoriesData[index].isSelected 
                      ? const Color(0xff51A8FF) 
                      : Colors.white
                  ),
                  child: SvgPicture.asset(
                    categoriesData[index].vector,
                    fit: BoxFit.none,
                  ),
                ),
              );
            }, 
            separatorBuilder: (context, indec) => const SizedBox(width: 50,), 
            itemCount: categoriesData.length
          ),
        )
      ],
    );
  }

  Container _header() {
    return Container(
      color: const Color(0xff51A8FF),
/* double.infity hace que el cotainer ocupe todo el espacio */        
      width: double.infinity,
      height: 350,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hi, Edi',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffFFFFFF)
                ),
              ),
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: SvgPicture.asset(
                  'assets/vectors/notification.svg',
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Let's find\nyour top doctor!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black.withOpacity(0.4),
                size: 25,
              ),
              hintText: "Search here...",
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w300
              ),
/* Eliminamos el border del Input */                
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)
              )
            ),
          )
        ],
      ),
    );
  }
} 