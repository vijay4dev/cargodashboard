import 'package:cargodashboard/utils/appcolors.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onCollapse;
  const Sidebar({super.key, required this.isExpanded, required this.onCollapse});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with TickerProviderStateMixin {
  bool isCargoExpanded = false;
  bool isPackagesExpanded = false; // Separate state for "Посылки"
  String selectedMenu = "На складе в Китае";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      
      builder: (context, constraints) {
        return AnimatedSize(
          
          duration: const Duration(milliseconds: 5), // nonzero duration
          curve: Curves.linear,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // height adjusts to its children
              children: [
                // Logo & Expand Icon
                Padding(
                  padding: const EdgeInsets.only(top: 10 , bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.isExpanded)
                        SizedBox(
                          width: 180,
                          height: 40,
                          child: Image.asset("assets/images/logo.png"),
                        )
                      else
                        Icon(Icons.menu),
                      if (widget.isExpanded)
                        IconButton(
                          onPressed: widget.onCollapse,
                          icon: const Icon(Icons.chevron_left, color: Colors.green, size: 30),
                        )
                    ],
                  ),
                ),
                

                // Inside your build() method under "Грузы" expandable menu:
                buildExpandableMenu(
                  icon: "assets/images/expandicon.png",
                  label: "Грузы",
                  isExpanded: widget.isExpanded,
                  expanded: isCargoExpanded,
                  toggle: () {
                    setState(() {
                      isCargoExpanded = !isCargoExpanded;
                    });
                  },
                  children: [
                    buildMenuItem(
                      "assets/images/expandicon.png",
                      "На складе в Китае",
                      widget.isExpanded,
                      selected: selectedMenu == "На складе в Китае",
                      onTap: () {
                        setState(() {
                          selectedMenu = "На складе в Китае";
                        });
                      },
                    ),
                    buildMenuItem(
                      "assets/images/PencilWriting.png",
                      "Сортировка",
                      widget.isExpanded,
                      selected: selectedMenu == "Сортировка",
                      onTap: () {
                        setState(() {
                          selectedMenu = "Сортировка";
                        });
                      },
                    ),
                    buildMenuItem(
                      "assets/images/Truck.png",
                      "Отправки",
                      widget.isExpanded,
                      
                      selected: selectedMenu == "Отправки",
                      onTap: () {
                        setState(() {
                          selectedMenu = "Отправки";
                        });
                      },
                    ),
                  ],
                ),
                // "Посылки" expandable menu
                buildExpandableMenu(
                  icon: "assets/images/cargo2.png",
                  label: "Посылки",
                  isExpanded: widget.isExpanded,
                  expanded: isPackagesExpanded,
                  toggle: () {
                    setState(() {
                      isPackagesExpanded = !isPackagesExpanded;
                    });
                  },
                  children: [
                    // Add "Посылки" menu items here
                  ],
                ),
                const Divider(),

                // "Выход" menu item (non-expandable)
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 10) , 
                  child: buildMenuItem("assets/images/Logout.png", "Выход", widget.isExpanded)  
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget buildMenuItem(
  String imageName,
  String label,
  bool isExpanded, {
  bool disabled = false,
  bool selected = false,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 18, top: 10, bottom: 10, right: 10),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 24,
            leading: SizedBox(
              width: 20,
              child: Opacity(
                opacity: selected ? 1 : 0.5,
                child: Image.asset(imageName),
              ),
            ),
            title: isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: selected
                                ? Colors.black
                                : Colors.black.withOpacity(0.6),
                        fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  )
                : null,
            enabled: !disabled,
            dense: true,
          ),
        ),
        if (selected && isCargoExpanded)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10) , bottomRight: Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.selected_menu_color_border[0],
                    AppColors.selected_menu_color_border[1],
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

  Widget buildExpandableMenu({
    required String icon,
    required String label,
    required bool isExpanded,
    required bool expanded,
    required VoidCallback toggle,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
      decoration: BoxDecoration(
        color: expanded ? AppColors.exapnded_background : Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 18),
            minLeadingWidth: 24,
            leading: SizedBox(
              width: 20,
              child: Image.asset(icon),
            ),
            title: isExpanded
                ? Text(label, style: TextStyle(fontWeight: expanded ? FontWeight.bold : FontWeight.w500))
                : null,
            trailing: isExpanded
                ? Icon(
                    expanded ? Icons.expand_more : Icons.chevron_right,
                    size: 18,
                  )
                : null,
            onTap: toggle,
            dense: true,
          ),
          if (expanded)
            ...children.map(
              (child) => Padding(
                padding: const EdgeInsets.all(0),
                child: child,
              ),
            ),
        ],
      ),
    );
  }
}
