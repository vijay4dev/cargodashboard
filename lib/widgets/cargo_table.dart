import 'package:cargodashboard/models/cargomodel.dart';
import 'package:flutter/material.dart';

class PaginatedCargoTable extends StatefulWidget {
  @override
  _PaginatedCargoTableState createState() => _PaginatedCargoTableState();
}

class _PaginatedCargoTableState extends State<PaginatedCargoTable> {
  int currentPage = 1;
  final int rowsPerPage = 10;

  List<CargoItem> allItems = List.generate(50, (index) => CargoItem(
  clientCode: '12345678',
  cargoNumber: '12345678',
  category: ['Одежда', 'Обувь', 'Мебель'][index % 3],
  quantity: index % 3 == 0 ? '5/10' : '10/10',
  status: index % 2 == 0 ? 'На складе в Китае' : 'В пути',
  comment: 'есть стеклянные посуды сделанные из...',
));


  @override
  Widget build(BuildContext context) {
    int start = (currentPage - 1) * rowsPerPage;
    int end = start + rowsPerPage;
    List<CargoItem> pageItems = allItems.sublist(
      start,
      end > allItems.length ? allItems.length : end,
    );

    return Container(
      width: double.infinity  ,
      decoration: BoxDecoration(
        color: Colors.white,  
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          // Table
          Table(
            columnWidths: {
              0: FixedColumnWidth(150),
              1: FixedColumnWidth(150),
              2: FixedColumnWidth(150),
              3: FixedColumnWidth(150),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
              6: FixedColumnWidth(150),
            },
            border: TableBorder(horizontalInside: BorderSide(color: Colors.grey.shade300)),
            children: [
              // Header
              TableRow(
                decoration: BoxDecoration(color: Colors.indigo[900] , borderRadius: BorderRadius.only(topLeft: Radius.circular(18) , topRight: Radius.circular(18))),
                children: [
                  tableHeader('Код клиента'),
                  tableHeader('Номер груза'),
                  tableHeader('Категория товара'),
                  tableHeader('Количество мест'),
                  tableHeader('Статус для клиента'),
                  tableHeader('Комментарий'),
                  SizedBox(), // For action buttons
                ],
              ),
              // Data Rows
              ...pageItems.asMap().entries.map((entry) {
                
                  final index = entry.key;
                  final item = entry.value;
                  final isInTransit = item.status == 'В пути';
                return TableRow(
                  
                  decoration: BoxDecoration(
                    color: item == pageItems[1] ? Colors.blue.shade50 : null,
                  ),
                  children: [
                    tableCell(item.clientCode),
                    tableCell(item.cargoNumber),
                    tableCell(item.category),
                    tableCell(item.quantity),
                    tableCell(
                      item.status,
                      textColor: isInTransit ? Colors.teal : Colors.black87,
                    ),
                    tableCell(item.comment, maxLines: 1),
                    
                    actionButtonsRow(index <= 3 ? true : false),
                  ],
                );
              }),
            ],
          ),

          Divider(),
          // Pagination
          paginationWidget(),
        ],
      ),
    );
  }

  Widget tableHeader(String text) => Padding(
        padding: const EdgeInsets.all(10),
        child: Text(text, textAlign: TextAlign.center , style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100 , fontSize: 15)),
      );

  Widget tableCell(String text, {int maxLines = 2, Color? textColor}) => Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor ?? Colors.black87),
        ),
      );

  Widget actionButtonsRow(is_red) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          is_red ? Icon(Icons.circle, size: 12, color: Colors.redAccent) : SizedBox(),
          SizedBox(width: 15),
          Opacity(opacity: 0.5 , child: SizedBox(height: 40 , width: 15 ,child: Image.asset("assets/images/Eye.png"))),
          SizedBox(width: 15),
          Opacity(opacity: 0.5 , child: SizedBox(height: 40 , width: 15 ,child: Image.asset("assets/images/Edit.png"))),
          SizedBox(width: 15),
          Opacity(opacity: 0.5 , child: SizedBox(height: 40 , width: 15 ,child: Image.asset("assets/images/Trash.png"))),
        ],
      );

  Widget paginationWidget() {
    int pageCount = (allItems.length / rowsPerPage).ceil();
    return Wrap(
      spacing: 8,
      
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
          onPressed: currentPage > 1 ? () => setState(() => currentPage--) : null,
          icon: Icon(Icons.chevron_left),
        ),
        ...List.generate(pageCount, (index) {
          final page = index + 1;
          return GestureDetector(
            onTap: () => setState(() => currentPage = page),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: page == currentPage ? Colors.blue.shade700 : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$page',
                style: TextStyle(color: page == currentPage ? Colors.white : Colors.black),
              ),
            ),
          );
        }),
        IconButton(
          onPressed: currentPage < pageCount ? () => setState(() => currentPage++) : null,
          icon: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
