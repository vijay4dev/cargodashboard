import 'package:cargodashboard/utils/appcolors.dart';
import 'package:cargodashboard/widgets/cargo_table.dart';
import 'package:flutter/material.dart';

class Maincontent extends StatefulWidget {
  const Maincontent({super.key});

  @override
  State<Maincontent> createState() => _MaincontentState();
}

class _MaincontentState extends State<Maincontent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.maincontent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            children: [
              // Header row with title and add cargo button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Грузы на складе в Китае",
                    style: TextStyle(
                      fontFamily: "Open Sans",
                      color: AppColors.head_txtcolor,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("tapped Добавить груз");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // Using Border.all instead of BoxBorder.all for clarity
                        border: Border.all(
                          width: 1,
                          color: AppColors.border_color,
                        ),
                      ),
                      child: Text(
                        "Добавить груз",
                        style: TextStyle(
                          color: AppColors.head_txtcolor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Search row with text field and icon button
              Row(
                children: [
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(7, 0, 0, 0),
                            spreadRadius: 0.5,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Введите номер груза',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              // Handle search action here
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              PaginatedCargoTable(),
            ],
          ),
        ),
      ),
    );
  }
}