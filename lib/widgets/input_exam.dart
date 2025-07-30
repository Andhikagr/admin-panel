// child: Padding(
//                         padding: EdgeInsets.only(left: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Icon(Icons.search, size: 16, color: Colors.grey),
//                             SizedBox(width: 5),
//                             Text(
//                               "Search...",
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 130,
//                       height: 35,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: const Color(0xFF02223B).withValues(alpha: 0.2),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(width: 5),
//                           Text(
//                             "Exam Status",
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Icon(Icons.arrow_drop_down, size: 16),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   height: 245,
//                   width: 250,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: BoxBorder.all(
//                       color: const Color(0xFF02223B).withValues(alpha: 0.2),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 120,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.blue,
//                           ),
//                           child: Image.asset("assets/covercbt.png", scale: 10),
//                         ),
//                         SizedBox(height: 10),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Matematika Exam",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Container(
//                                 width: 70,
//                                 height: 20,
//                                 decoration: BoxDecoration(
//                                   color: const Color.fromARGB(
//                                     255,
//                                     255,
//                                     246,
//                                     234,
//                                   ),
//                                   border: BoxBorder.all(
//                                     color: const Color.fromARGB(
//                                       255,
//                                       255,
//                                       226,
//                                       187,
//                                     ),
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "Active",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 10,
//                                       color: const Color.fromARGB(
//                                         255,
//                                         235,
//                                         155,
//                                         51,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(Icons.calendar_month),
//                             SizedBox(width: 10),
//                             Text(
//                               "Started on 26 July 2025",
//                               style: TextStyle(fontSize: 11),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5),
//                         Row(
//                           children: [
//                             Icon(Icons.timelapse),
//                             SizedBox(width: 10),
//                             Text(
//                               "Time 08.00 - 10.00 wib",
//                               style: TextStyle(fontSize: 11),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
