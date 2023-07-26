// ignore_for_file: avoid_print

class MapPreHandle {
  final int mapWidth;
  final int mapHeight;

  MapPreHandle({
    required this.mapWidth,
    required this.mapHeight,
  }) {
    generateMap();
  }
  late MapObject start;
  late MapObject end;
  late List<List<int>> map;
  // x, y, width, height of the spot
  late List<MapObject> spot = [];
  late List<MapObject> obstacles = [];

  get getMap => map;

  get getMapWidth => mapWidth;

  get getMapHeight => mapHeight;

  void generateMap() {
    map = List.generate(mapHeight, (i) => List.generate(mapWidth, (j) => 1));
    spot.clear();
    obstacles.clear();
  }

  void drawObstacle({
    // row, column
    required int row,
    required int col,
    required int width,
    required int height,
  }) {
    obstacles.add(MapObject(row, col, width, height));
    for (int i = row; i < row + height; i++) {
      for (int j = col; j < col + width; j++) {
        map[i][j] = 0;
      }
    }
  }

  void drawSpot({
    // row, column
    required int row,
    required int col,
    required int width,
    required int height,
  }) {
    spot.add(MapObject(row, col, width, height));
    for (int i = row; i < row + height; i++) {
      for (int j = col; j < col + width; j++) {
        map[i][j] = 0;
      }
    }
  }

  List<List<int>> findPossibleRoad() {
    List<List<int>> possibleRoad = [];
    // Wall is 0, Empty is 1, Road is 9
    // Draw vertical road
    for (int i = 0; i < map.length; i++) {
      List<int> temp = [];
      if (map[i][0] == 1) {
        temp.add(0);
      }
      for (int j = 0; j < map[0].length - 1; j++) {
        if (map[i][j] == 1 && temp.isEmpty) {
          temp.add(j);
        }
        if (map[i][j + 1] == 0 && temp.isNotEmpty) {
          temp.add(j);
        }
        if (j == map[0].length - 2 && temp.length == 1) {
          temp.add(j + 1);
        }
        if (temp.length == 2) {
          int middle = (temp[0] + temp[1]) ~/ 2;
          for (int row = 0;
              row < map.length &&
                  map[i][0] != 1 &&
                  map[i][map[i].length - 1] != 1;
              row++) {
            if (checkTouchingObstacle(row, middle)) {
              //  print("Touching obstacle");
            } else if (checkTouchingSpot(row + 1, middle, null) ||
                checkTouchingSpot(row, middle, null)) {
              //  print("Touching spot");
            } else if (map[row][middle] != 0) {
              possibleRoad.add([row, middle]);
            }
          }
          temp.clear();
        }
      }
    }

    // Draw horizontal road
    for (int j = 0; j < map[0].length; j++) {
      // Temp y coordinate
      List<int> temp = [];
      if (map[0][j] == 1) {
        temp.add(0);
      }
      for (int i = 0; i < map.length - 1; i++) {
        if (map[i][j] == 1 && temp.isEmpty) {
          temp.add(i);
        }
        if (map[i + 1][j] == 0 && temp.isNotEmpty) {
          temp.add(i);
        }
        if (i == map.length - 2 && temp.length == 1) {
          temp.add(i + 1);
        }
        if (temp.length == 2) {
          int middle = (temp[0] + temp[1]) ~/ 2;
          for (int col = 0; col < map[0].length; col++) {
            if (checkTouchingObstacle(middle, col)) {
              //  print("Touching obstacle");
            } else if (checkTouchingSpot(middle, col + 1, null) ||
                checkTouchingSpot(middle, col, null)) {
              //  print("Touching spot");
            } else if (map[middle][col] != 0) {
              possibleRoad.add([middle, col]);
            }
          }
          temp.clear();
        }
      }
    }
    // For each spot, determine if width or height is greater, than draw vertical or horizontal line based on that
    for (int i = 0; i < spot.length; i++) {
      int spotRow = spot[i].row;
      int spotCol = spot[i].col;
      int width = spot[i].width;
      int height = spot[i].height;
      int middleRow = spotRow + height ~/ 2;
      int middleCol = spotCol + width ~/ 2;
      // If height is greater than width, draw vertical line
      if (width < height) {
        for (int row = 0; row < map.length; row++) {
          // If the road touch the obstacle, don't draw
          if (checkTouchingObstacle(row, middleCol)) {
            //  print("Touching obstacle");
          } else if (checkTouchingSpot(row + 1, middleCol, spot[i]) ||
              checkTouchingSpot(row, middleCol, spot[i])) {
            //  print("Touching spot");
          } else if (map[row][middleCol] != 0) {
            possibleRoad.add([row, middleCol]);
          }
        }
      }
      // Draw horizontal line
      else {
        for (int col = 0; col < map[0].length; col++) {
          if (checkTouchingObstacle(middleRow, col)) {
            //  print("Touching obstacle");
          } else if (checkTouchingSpot(middleRow, col + 1, spot[i]) ||
              checkTouchingSpot(middleRow, col, spot[i])) {
            //  print("Touching spot");
          } else if (map[middleRow][col] != 0) {
            possibleRoad.add([middleRow, col]);
          }
        }
      }
    }
// Draw vertical and horizontal line through the middle of the start and end
    // Get the middle row and col of start
    int startMiddleRow = start.row + start.height ~/ 2;
    int startMiddleCol = start.col + start.width ~/ 2;
    for (int row = 0; row < map.length; row++) {
      if (checkTouchingObstacle(row, startMiddleCol)) {
        //  print("Touching obstacle");
      } else if (checkTouchingSpot(row + 1, startMiddleCol, null) ||
          checkTouchingSpot(row, startMiddleCol, null)) {
        //  print("Touching spot");
      } else if (map[row][startMiddleCol] != 0) {
        possibleRoad.add([row, startMiddleCol]);
      }
    }
    for (int col = 0; col < map[0].length; col++) {
      if (checkTouchingObstacle(startMiddleRow, col)) {
        //  print("Touching obstacle");
      } else if (checkTouchingSpot(startMiddleRow, col, null)) {
        //  print("Touching spot");
      } else if (map[startMiddleRow][col] != 0) {
        possibleRoad.add([startMiddleRow, col]);
      }
    }

    // Get the middle row and col of end
    int endMiddleRow = end.row + end.height ~/ 2;
    int endMiddleCol = end.col + end.width ~/ 2;
    for (int row = 0; row < map.length; row++) {
      if (checkTouchingObstacle(row, endMiddleCol)) {
        //  print("Touching obstacle");
      } else if (checkTouchingSpot(row + 1, endMiddleCol, null) ||
          checkTouchingSpot(row, endMiddleCol, null)) {
        //  print("Touching spot");
      } else if (map[row][endMiddleCol] != 0) {
        possibleRoad.add([row, endMiddleCol]);
      }
    }
    for (int col = 0; col < map[0].length; col++) {
      if (checkTouchingObstacle(endMiddleRow, col)) {
        //  print("Touching obstacle");
      } else if (checkTouchingSpot(endMiddleRow, col + 1, null) ||
          checkTouchingSpot(endMiddleRow, col, null)) {
        //  print("Touching spot");
      } else if (map[endMiddleRow][col] != 0) {
        possibleRoad.add([endMiddleRow, col]);
      }
    }

    for (int i = 0; i < possibleRoad.length; i++) {
      map[possibleRoad[i][0]][possibleRoad[i][1]] = 9;
    }

    return map;
  }

  // Check if road is touching the obstacle, check 8 directions of road
  bool checkTouchingObstacle(int row, int col) {
    List<List<int>> directions = [
      [row - 1, col - 1],
      [row - 1, col],
      [row - 1, col + 1],
      [row, col - 1],
      [row, col + 1],
      [row + 1, col - 1],
      [row + 1, col],
      [row + 1, col + 1],
    ];
    for (int i = 0; i < directions.length; i++) {
      int directionRow = directions[i][0];
      int directionCol = directions[i][1];
      for (int j = 0; j < obstacles.length; j++) {
        int obstacleRow = obstacles[j].row;
        int obstacleCol = obstacles[j].col;
        int width = obstacles[j].width;
        int height = obstacles[j].height;
        if (directionRow >= obstacleRow &&
            directionRow <= obstacleRow + height &&
            directionCol >= obstacleCol &&
            directionCol <= obstacleCol + width) {
          return true;
        }
      }
    }
    return false;
  }

  // bool checkTouchingObstacle(int row, int col) {
  //   for (int i = 0; i < obstacles.length; i++) {
  //     int obstacleRow = obstacles[i].row;
  //     int obstacleCol = obstacles[i].col;
  //     int width = obstacles[i].width;
  //     int height = obstacles[i].height;
  //     if (row >= obstacleRow &&
  //         row <= obstacleRow + height &&
  //         col >= obstacleCol &&
  //         col <= obstacleCol + width) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // Check if the road is touching spot except current spot
  bool checkTouchingSpot(int row, int col, MapObject? currentSpot) {
    for (int i = 0; i < spot.length; i++) {
      if (currentSpot != null) {
        if (spot[i] != currentSpot) {
          int spotRow = spot[i].row;
          int spotCol = spot[i].col;
          int width = spot[i].width;
          int height = spot[i].height;
          if (row >= spotRow &&
              row <= spotRow + height &&
              col >= spotCol &&
              col <= spotCol + width) {
            return true;
          }
        }
      } else {
        int spotRow = spot[i].row;
        int spotCol = spot[i].col;
        int width = spot[i].width;
        int height = spot[i].height;
        if (row >= spotRow &&
            row <= spotRow + height &&
            col >= spotCol &&
            col <= spotCol + width) {
          return true;
        }
      }
    }
    return false;
  }

  void printMap(List<List<int>> map) {
    for (int i = 0; i <= map.length - 1; i++) {
      print("row " + i.toString() + ":" + map[i].toString());
    }
  }
}

class MapObject {
  int row;
  int col;
  int width;
  int height;
  late bool horizontal;
  late String? title;
  late bool clickable;

  MapObject(this.row, this.col, this.width, this.height,
      [this.title, this.clickable = true]) {
    horizontal = width > height;
  }
}
