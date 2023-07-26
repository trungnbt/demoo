import 'package:webspc/path_finding/map_pre_handle.dart';

enum Direction { up, down, left, right }

class PathFindingAlgorithm {
  final Grid grid;
  PathFindingAlgorithm({required this.grid});

  List<List<int>> findPath(MapObject start, MapObject end,
      [bool onRoad = true]) {
    // Check if start and end are valid
    // if (onRoad) {
    //   if (grid.grid[start.row][start.col] != 9) {
    //     print("Start is not valid");
    //     return [];
    //   }
    //   if (grid.grid[end.row][end.col] != 9) {
    //     print("End is not valid");
    //     return [];
    //   }
    // }
    // Check if end is on left of map
    if (end.col > grid.grid[0].length ~/ 2) {
      return findPathAl(start, end);
    }
    List<Node> openList = [];
    List<Node> closedList = [];
    int startRow;
    int startCol;
    int endRow;
    int endCol;

    // Check if start is horizontal
    if (start.horizontal) {
      // startRow is middle row of point
      startRow = start.row + start.height ~/ 2;
      // Check if start is left or right of map
      if (start.col < grid.grid[0].length ~/ 2) {
        startCol = start.col + start.width;
      } else {
        startCol = start.col - 1;
      }
    } else {
      // StartCol is middle of point
      startCol = start.col + start.width ~/ 2;
      // Check if start is on up or bottom map
      if (start.row < grid.grid.length ~/ 2) {
        startRow = start.row + start.height;
      } else {
        startRow = start.row - 1;
      }
    }

    if (end.horizontal) {
      // endRow is middle row of point
      endRow = end.row + end.height ~/ 2;
      // Check if end is left or right of map
      if (end.col < grid.grid[0].length ~/ 2) {
        endCol = end.col + end.width;
      } else {
        endCol = end.col - 1;
      }
    } else {
      // endCol is middle of point
      endCol = end.col + end.width ~/ 2;
      // Check if end is on up or bottom map
      if (end.row < grid.grid.length ~/ 2) {
        endRow = end.row + end.height;
      } else {
        endRow = end.row + end.height;
      }
    }

    // Print value of start and end
    print("Start: $startRow, $startCol, ${grid.grid[startRow][startCol]}");
    print("End: $endRow, $endCol, ${grid.grid[endRow][endCol]}");

    Node startNode = Node(startRow, startCol, 0, 0, null);
    Node endNode = Node(endRow, endCol, 0, 0, null);

    openList.add(startNode);

    while (openList.isNotEmpty) {
      Node currentNode = openList.first;
      int currentIndex = 0;

      for (int i = 0; i < openList.length; i++) {
        if (openList[i].fCost < currentNode.fCost) {
          currentNode = openList[i];
          currentIndex = i;
        }
      }

      openList.removeAt(currentIndex);
      closedList.add(currentNode);

      if (currentNode.row == endNode.row && currentNode.col == endNode.col) {
        List<Node> path = [];
        Node? current = currentNode;

        while (current != null) {
          path.add(current);
          current = current.parent;
        }

        return makeMap(path.reversed.toList(), grid.grid);
      }

      List<Node> neighbors = [];
      // List<List<int>> directions = [
      //   [1, 0], // down
      //   [-1, 0], // up
      //   [0, 1], // right
      //   [0, -1], // left
      // ];

      List<Direction> directions = [];

      // Choose which directions is straight which current node and its parent
      if (currentNode.parent != null) {
        int parentRow = currentNode.parent!.row;
        int parentCol = currentNode.parent!.col;
        // Determine if the parent is above, below, left, or right of the current node
        if (parentRow == currentNode.row - 1) {
          // down, right, left
          directions = [
            Direction.down,
            Direction.right,
            Direction.left,
          ];
        } else if (parentRow == currentNode.row + 1) {
          // Parent is below current node
          // up, right, left
          directions = [
            Direction.up,
            Direction.right,
            Direction.left,
          ];
        } else if (parentCol == currentNode.col - 1) {
          // Parent is left of current node
          // right, up, down
          directions = [
            Direction.right,
            Direction.up,
            Direction.down,
          ];
        } else if (parentCol == currentNode.col + 1) {
          // Parent is right of current node
          // left, up, down
          directions = [
            Direction.left,
            Direction.up,
            Direction.down,
          ];
        }
      } else {
        if (start.horizontal) {
          // Priority move horizontal
          // right, left, up, down
          directions = [
            Direction.right,
            Direction.left,
            Direction.up,
            Direction.down,
          ];
        } else {
          // Priority move vertical
          // up, down, left, right
          directions = [
            Direction.up,
            Direction.down,
            Direction.left,
            Direction.right,
          ];
        }
      }

      for (final direction in directions) {
        List<List<int>> directionValues = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
        ];

        int neighborRow = currentNode.row + directionValues[direction.index][0];
        int neighborCol = currentNode.col + directionValues[direction.index][1];

        if (neighborRow >= 0 &&
            neighborRow < grid.rows &&
            neighborCol >= 0 &&
            neighborCol < grid.cols) {
          if (onRoad) {
            if (grid.grid[neighborRow][neighborCol] == 9) {
              neighbors.add(Node(
                neighborRow,
                neighborCol,
                currentNode.gCost + 1,
                calculateHCost(
                    neighborRow, neighborCol, endNode.row, endNode.col),
                currentNode,
              ));
            }
          } else {
            neighbors.add(Node(
              neighborRow,
              neighborCol,
              currentNode.gCost + 1,
              calculateHCost(
                  neighborRow, neighborCol, endNode.row, endNode.col),
              currentNode,
            ));
          }
        }
      }

      for (final neighbor in neighbors) {
        if (closedList.any(
            (node) => node.row == neighbor.row && node.col == neighbor.col)) {
          continue;
        }

        int newCostToNeighbor = currentNode.gCost + 1;
        bool isInOpenList = openList.any(
            (node) => node.row == neighbor.row && node.col == neighbor.col);

        if (!isInOpenList || newCostToNeighbor < neighbor.gCost) {
          neighbor.gCost = newCostToNeighbor;
          neighbor.hCost = calculateHCost(
              neighbor.row, neighbor.col, endNode.row, endNode.col);
          neighbor.parent = currentNode;

          if (!isInOpenList) {
            openList.add(neighbor);
          }
        }
      }
    }

    // No path found
    return [];
  }

  int calculateHCost(int x1, int y1, int x2, int y2) {
    return (x2 - x1).abs() + (y2 - y1).abs();
  }

  List<List<int>> makeMap(List<Node> path, List<List<int>> gridData) {
    for (Node node in path) {
      gridData[node.row][node.col] = 2;
    }
    return gridData;
  }

  List<List<int>> findPathAl(MapObject start, MapObject end) {
    List<List<int>> map = grid.grid;

    int startRow;
    int startCol;
    int endRow;
    int endCol;
    // Check if start is horizontal
    if (start.horizontal) {
      // startRow is middle row of point
      startRow = start.row + start.height ~/ 2;
      // Check if start is left or right of map
      if (start.col < grid.grid[0].length ~/ 2) {
        startCol = start.col + start.width;
      } else {
        startCol = start.col - 1;
      }
    } else {
      // StartCol is middle of point
      startCol = start.col + start.width ~/ 2;
      // Check if start is on up or bottom map
      if (start.row < grid.grid.length ~/ 2) {
        startRow = start.row + start.height;
      } else {
        startRow = start.row - 1;
      }
    }

    if (end.horizontal) {
      // endRow is middle row of point
      endRow = end.row + end.height ~/ 2;
      // Check if end is left or right of map
      if (end.col < grid.grid[0].length ~/ 2) {
        endCol = end.col + end.width;
      } else {
        endCol = end.col - 1;
      }
    } else {
      // endCol is middle of point
      endCol = end.col + end.width ~/ 2;
      // Check if end is on up or bottom map
      if (end.row < grid.grid.length ~/ 2) {
        endRow = end.row + end.height;
      } else {
        endRow = end.row + end.height;
      }
    }
    List<Direction> navigateStep = [];
    if (end.title == "C04") {
      navigateStep = [
        Direction.right,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.right,
        Direction.right,
        Direction.right,
        Direction.right,
        Direction.up,
        Direction.up,
        Direction.right
      ];
    } else if (end.title == "C03") {
      navigateStep = [
        Direction.right,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.right,
        Direction.right,
        Direction.right,
        Direction.right,
        Direction.down,
        Direction.right,
      ];
    } else if (end.title == "C02") {
      navigateStep = [
        Direction.right,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.right,
        Direction.right,
        Direction.right,
        Direction.right,
        Direction.down,
        Direction.down,
        Direction.down,
        Direction.down,
        Direction.right,
        Direction.right,
        Direction.right,
      ];
    } else if (end.title == "C01") {
      navigateStep = [
        Direction.right,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.up,
        Direction.right,
        Direction.right,
        Direction.down,
        Direction.right,
      ];
    }
    map = moveFollowNavigate(
        map, navigateStep, startRow, startCol, endRow, endCol);
    return map;
  }

  List<List<int>> moveFollowNavigate(
      List<List<int>> map,
      List<Direction> navigateStep,
      int startRow,
      int startCol,
      int endRow,
      int endCol) {
    List<List<int>> directionValues = [
      [-1, 0], // up
      [1, 0], // down
      [0, -1], // left
      [0, 1], // right
    ];
    List<List<int>> path = [];
    path.add([startRow, startCol]);

    int currentRow = startRow;
    int currentCol = startCol;

    for (int i = 0; i < navigateStep.length; i++) {
      Direction currentDirection = navigateStep[i];

      while (true) {
        currentRow = currentRow + directionValues[currentDirection.index][0];
        currentCol = currentCol + directionValues[currentDirection.index][1];
        if (currentCol >= map.length || currentRow >= map[0].length) {
          break;
        }
        path.add([currentRow, currentCol]);
        if (isCrossroad(currentRow, currentCol)) {
          print("Crossroad: $currentRow, $currentCol");
          break;
        }
      }
    }

    // Add the end point to the path
    // Mark the path on the map
    for (List<int> position in path) {
      int row = position[0];
      int col = position[1];
      map[row][col] = 2; // Mark the path with value 2
    }
    return map;
  }

  // Check if Node is in crossroad
  bool isCrossroad(int row, int col) {
    // Check 4 neighbor of node, if 2 of them is road, return true
    int count = 0;
    List<List<int>> directions = [
      [1, 0], // down
      [-1, 0], // up
      [0, 1], // right
      [0, -1], // left
    ];
    for (final direction in directions) {
      int neighborRow = row + direction[0];
      int neighborCol = col + direction[1];
      if (neighborRow >= 0 &&
          neighborRow < grid.rows &&
          neighborCol >= 0 &&
          neighborCol < grid.cols) {
        if (grid.grid[neighborRow][neighborCol] == 9) {
          count++;
        }
      }
    }
    return count > 2;
  }
}

class Grid {
  List<List<int>> grid;
  late int rows;
  late int cols;

  Grid(this.grid) {
    rows = grid.length;
    cols = grid[0].length;
  }
}

class Node {
  int row;
  int col;
  int gCost;
  int hCost;
  Node? parent;

  Node(this.row, this.col, this.gCost, this.hCost, this.parent);

  int get fCost => gCost + hCost;
}
