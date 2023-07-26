import 'package:flutter/material.dart';
import 'package:webspc/Api_service/spot_service.dart';
import 'package:webspc/DTO/spot.dart';
import 'package:webspc/path_finding/map_painter.dart';
import 'package:webspc/path_finding/map_pre_handle.dart';
import 'package:webspc/path_finding/path_finding_algorithm.dart';
import 'package:webspc/resource/Home/home_page.dart';

import '../../DTO/cars.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key, required this.listSpot, this.boughtSpot, this.car});
  final List<Spot> listSpot;
  final Spot? boughtSpot;
  final Car? car;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapObject end;
  late MapObject start;
  final MapObject exit = MapObject(46, 42, 8, 6);
  late List<MapObject> spots;
  late List<MapObject> obstacles;
  Spot? boughtSpot;
  MapObject? selectedSpot;
  MapPreHandle mapPreHandle = MapPreHandle(
    mapWidth: 50,
    mapHeight: 50,
  );

  List<List<int>> navigatedMap = [];
  void initialMap() {
    mapPreHandle.start = start;
    mapPreHandle.end = end;
    mapPreHandle.generateMap();
    // Draw the spot from spots list
    for (int i = 0; i < spots.length; i++) {
      mapPreHandle.drawSpot(
        row: spots[i].row,
        col: spots[i].col,
        width: spots[i].width,
        height: spots[i].height,
      );
    }
    // Draw obstacles from obstacles list
    for (int i = 0; i < obstacles.length; i++) {
      mapPreHandle.drawObstacle(
        row: obstacles[i].row,
        col: obstacles[i].col,
        width: obstacles[i].width,
        height: obstacles[i].height,
      );
    }
    setState(() {
      navigatedMap = mapPreHandle.map;
    });
  }

  bool handleSpotStatus(Spot spot) {
    if (spot.owned == null) {
      return false;
    } else {
      if (spot.owned!) {
        return false;
      } else {
        if (spot.available!) {
          return false;
        } else {
          return true;
        }
      }
    }
  }

  @override
  void initState() {
    setState(() {
      boughtSpot = widget.boughtSpot;
    });
    start = MapObject(46, 0, 8, 4);
    end = MapObject(0, 0, 8, 6);
    spots = [
      // Row, col, width, height
      MapObject(0, 0, 8, 6, "A04", handleSpotStatus(widget.listSpot[7])),
      MapObject(0, 20, 6, 8, "B02", handleSpotStatus(widget.listSpot[2])),
      MapObject(0, 42, 8, 6, "C04", handleSpotStatus(widget.listSpot[3])),
      MapObject(13, 0, 8, 6, "A03", handleSpotStatus(widget.listSpot[0])),
      MapObject(13, 42, 8, 6, "C03", handleSpotStatus(widget.listSpot[1])),
      MapObject(22, 0, 8, 6, "A02", handleSpotStatus(widget.listSpot[6])),
      MapObject(22, 42, 8, 6, "C02", handleSpotStatus(widget.listSpot[9])),
      MapObject(35, 0, 8, 6, "A01", handleSpotStatus(widget.listSpot[5])),
      MapObject(35, 20, 6, 8, "B01", handleSpotStatus(widget.listSpot[8])),
      MapObject(35, 42, 8, 6, "C01", handleSpotStatus(widget.listSpot[4])),
    ];

    obstacles = [MapObject(12, 16, 20, 20, "Elevator")];
    initialMap();
    // Check if boughtSpot is not null
    if (mounted && boughtSpot != null) {
      // Find spot in spots list has the same spotId with boughtSpot

      for (int i = 0; i < spots.length; i++) {
        if (spots[i].title == boughtSpot!.location) {
          // Set start to the spot
          List<List<int>> newMap = mapPreHandle.findPossibleRoad();
          Grid grid = Grid(navigatedMap);
          PathFindingAlgorithm pathFindingV2 = PathFindingAlgorithm(grid: grid);
          List<List<int>> navMap = pathFindingV2.findPath(start, spots[i]);
          if (newMap.isNotEmpty) {
            setState(() {
              navigatedMap = navMap;
            });
          }
          break;
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double mapWidthOnScreen =
        MediaQuery.of(context).size.width / mapPreHandle.mapWidth;
    final double mapHeightOnScreen =
        MediaQuery.of(context).size.width / mapPreHandle.mapHeight;
    // Show the map
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        // centerTitle: false,
        // automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 178, 179, 187),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Parking Spot (S101 Floor 1)",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24),
          color: Color(0xff212435),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: widget.listSpot.isEmpty
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        // Draw the map on top of the stack
                        children: [
                          // Draw start point
                          Positioned(
                            left: start.col * mapWidthOnScreen,
                            top: start.row * mapHeightOnScreen,
                            child: Container(
                              width: 66,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: Color(0x4d9e9e9e), width: 1),
                              ),
                              child: const Center(
                                child: Text(
                                  'You',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: exit.col * mapWidthOnScreen,
                            top: exit.row * mapHeightOnScreen,
                            child: Container(
                              width: 66,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: Color(0x4d9e9e9e), width: 1),
                              ),
                              child: const Center(
                                child: Text(
                                  'Exit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Draw spot and obstacles
                          for (MapObject obstacle in obstacles)
                            Positioned(
                              left: obstacle.col * mapWidthOnScreen,
                              top: 120,
                              child: Container(
                                width: 150,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0x1f000000),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: Color(0x4d9e9e9e), width: 1),
                                ),
                                child: Center(
                                  child: Text(
                                    obstacle.title ?? 'Obstacle',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          CustomPaint(
                            painter: MapPainter(
                                navigatedMap,
                                [start.row, start.col],
                                [end.row, end.col]), // Provide the map data
                            size: Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.width,
                            ),
                          ),
                          for (MapObject spot in spots)
                            Positioned(
                              left: spot.col * mapWidthOnScreen,
                              top: spot.row * mapHeightOnScreen,
                              child: GestureDetector(
                                onTap: () {
                                  if (spot.clickable ||
                                      spot.title == boughtSpot!.location) {
                                    bool showNavigator = true;
                                    Spot? tempSpot;
                                    for (var spotCar in widget.listSpot) {
                                      if (spotCar.location == spot.title) {
                                        tempSpot = spotCar;
                                        break;
                                      }
                                    }
                                    if (boughtSpot == null &&
                                        tempSpot != null &&
                                        (tempSpot.carId == null ||
                                            tempSpot.carId!.isEmpty)) {
                                      buildParkDialog(context, tempSpot);
                                     // showNavigator = false;
                                    }
                                    if (tempSpot != null &&
                                        tempSpot.carId != null &&
                                        tempSpot.carId!.isNotEmpty) {
                                      if (tempSpot.carId != boughtSpot!.carId) {
                                        showTakenDialog(context);
                                        showNavigator = false;
                                      }
                                    }
                                    if (showNavigator) {
                                      initialMap();
                                      mapPreHandle.findPossibleRoad();
                                      Grid grid = Grid(navigatedMap);
                                      PathFindingAlgorithm pathFindingV2 =
                                          PathFindingAlgorithm(grid: grid);
                                      List<List<int>> mapWithNavigator =
                                          pathFindingV2.findPath(start, spot);
                                      if (mapWithNavigator.isNotEmpty) {
                                        setState(() {
                                          navigatedMap = mapWithNavigator;
                                          selectedSpot = spot;
                                        });
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  width: 80,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: spot == selectedSpot
                                        ? Colors.green
                                        : (boughtSpot != null &&
                                                spot.title ==
                                                    boughtSpot!.location)
                                            ? const Color.fromARGB(
                                                255, 133, 186, 230)
                                            : spot.clickable
                                                ? const Color.fromARGB(
                                                    255, 194, 190, 190)
                                                : Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(
                                        color: Color(0x4d9e9e9e), width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      spot.title ?? 'Spot',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.4),
                    Container(
                        // margin: EdgeInsets.only(top: 10, left: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 305,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/bga1png.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 40, left: 20, bottom: 40, right: 20),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 142, 137, 137)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              )),
                          child: Column(children: [
                            Align(
                              // alignment: Alignment.topCenter,
                              child: Text(
                                'Your spot you was bought: ${boughtSpot?.location ?? 'none'}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "${widget.car!.carName}   ${widget.car!.carPlate}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              child: Stack(children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Image.asset("images/ca.png"),
                                )
                              ]),
                            )
                          ]),
                        ))
                    // Button to generate a random map
                  ],
                ),
        ),
      ),
    );
  }

  Future<dynamic> showTakenDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'This spot has been taken by another car',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> buildParkDialog(BuildContext context, Spot spot) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Do you want to park at ${spot.location}?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Find the spot in listSpot with location is spot.title
                spot.carId = widget.car!.carId;
                SpotDetailService.updateSpot(spot).then((value) {
                  if (value) {
                    setState(() {
                      boughtSpot = spot;
                    });
                  }
                });
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
