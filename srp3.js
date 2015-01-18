Snake.prototype.moveStep = function() {
  var nextHeadPoint,
      headPoint = this.headPoint();

  switch (this.currentDirection) {
  case 'left':
    nextHeadPoint = new Point(headPoint.x - 1, headPoint.y);
    break;
  case 'right':
    nextHeadPoint = new Point(headPoint.x + 1, headPoint.y);
    break;
  case 'up':
    nextHeadPoint = new Point(headPoint.x, headPoint.y - 1);
    break;
  case 'down':
    nextHeadPoint = new Point(headPoint.x, headPoint.y + 1);
    break;
  }

  if (nextHeadPoint.x < 0) {
    nextHeadPoint.x = GRID_DIMENSION_HORIZONTAL - 1;
  } else if (nextHeadPoint.x >= GRID_DIMENSION_HORIZONTAL) {
    nextHeadPoint.x = 0;
  } else if (nextHeadPoint.y < 0) {
    nextHeadPoint.y = GRID_DIMENSION_VERTICAL - 1;
  } else if (nextHeadPoint.y >= GRID_DIMENSION_VERTICAL) {
    nextHeadPoint.y = 0;
  }

  if (!this.keepLastPosition) {
    this.positionsArray.shift();
  } else {
    this.keepLastPosition = false;
  }

  this.positionsArray.push(nextHeadPoint);
  this.canSetDirection = true;
};
