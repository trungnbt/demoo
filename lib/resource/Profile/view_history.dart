import 'package:flutter/material.dart';
import 'package:webspc/Api_service/history_services.dart';
import 'package:webspc/DTO/history.dart';

class ViewUserHistoryPage extends StatefulWidget {
  const ViewUserHistoryPage({super.key});
  static const routeName = 'viewUserHistoryPage';

  @override
  State<ViewUserHistoryPage> createState() => _ViewUserHistoryPageState();
}

class _ViewUserHistoryPageState extends State<ViewUserHistoryPage> {
  bool isLoading = true;
  List<History> listHistory = [];
  List<History> filteredHistory = [];
  TextEditingController searchController = TextEditingController();
  DateTime? selectedDate;
  String? searchQuery;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  List<History> getFilteredHistory() {
    List<History> filteredList = listHistory;

    // Filter by car plate
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      filteredList = filteredList
          .where((history) => history.carPlate!
              .toLowerCase()
              .contains(searchQuery!.toLowerCase()))
          .toList();
    }

    // Filter by selected date
    if (selectedDate != null) {
      filteredList = filteredList.where((history) {
        final historyDate = DateTime.parse(history.timeIn ?? '').toLocal();
        return historyDate.year == selectedDate!.year &&
            historyDate.month == selectedDate!.month &&
            historyDate.day == selectedDate!.day;
      }).toList();
    }
    return filteredList;
  }

  void resetFilters() {
    searchController.clear();
    setState(() {
      searchQuery = null;
      selectedDate = null;
    });
  }

  void getListHistory() {
    isLoading = false;
    HistoryService.getListHistory().then((value) {
      // Sort by time in
      value.sort((a, b) => DateTime.parse(b.timeIn ?? '')
          .compareTo(DateTime.parse(a.timeIn ?? '')));
      setState(() {
        listHistory = value;
      });
    });
  }

  @override
  void initState() {
    getListHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/bga1png.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Your History",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                // Add search bar
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      hintText: 'Enter car plate to search',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        selectedDate == null
                            ? 'Select Date'
                            : 'Selected Date: ${selectedDate!.toString().substring(0, 10)}',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: resetFilters,
                      child: Text('Reset Filters'),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: getFilteredHistory().length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            getFilteredHistory()[index].carPlate ?? '',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   'Name: ${DateTime.parse(listHistory[index].userId ?? '').toString().substring(0, 19)}',
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.black,
                              //     decoration: TextDecoration.none,
                              //   ),
                              // ),
                              getFilteredHistory()[index].timeIn == null
                                  ? Text(
                                      'Time in:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  : Text(
                                      'Time in: ${DateTime.parse(getFilteredHistory()[index].timeIn!).toLocal().toString().substring(0, 19)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                              getFilteredHistory()[index].timeOut == null
                                  ? Text(
                                      'Time out:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  : Text(
                                      'Time out: ${DateTime.parse(getFilteredHistory()[index].timeOut!).toLocal().toString().substring(0, 19)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                            ],
                          ),
                          trailing: Text(
                            'Amount',
                            semanticsLabel: listHistory[index].amount ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      );
    }
  }
}
