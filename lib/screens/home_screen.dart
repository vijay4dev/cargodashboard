import 'package:cargodashboard/screens/Maincontent.dart';
import 'package:cargodashboard/screens/sidebar.dart';
import 'package:cargodashboard/utils/appcolors.dart';
import 'package:flutter/material.dart';

class WarehouseScreen extends StatefulWidget {
  @override
  _WarehouseScreenState createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  bool isSidebarExpanded = false; // default: sidebar shown

  void toggleSidebar() {
    setState(() {
      isSidebarExpanded = !isSidebarExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.maincontent,
      body: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar
          GestureDetector(
            onTap: toggleSidebar,
            child: AnimatedContainer(
              // height: 600,
              
              color: Colors.transparent,
              duration: Duration(milliseconds: 0),
              width: isSidebarExpanded ? 250 : 70, // adjust as needed
              child: Sidebar(isExpanded: isSidebarExpanded ,onCollapse: toggleSidebar),
            ),
          ),

            // Main Content
          Expanded(
            child: Column(
              children: [
                // Header with toggle button
                Container(
                  padding:  EdgeInsetsGeometry.only(top: 15, bottom: 15 , left: 30 , right: 30),
                  color: AppColors.appbar_background,
                  child: Row(
                    children: [
                      Container(),
                      
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Александр Прокофьев',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Супер Админ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 12),
                          
                          // Circular avatar
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Color(0xFF1CC38E), // the greenish color in screenshot
                            child: Text(
                              'AU',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
                Expanded(
                  child: Maincontent(), // Your table/search/etc
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
