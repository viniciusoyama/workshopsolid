// Plotando somente o ponto
var Snake = function(initialPositionsArray, initialDirection) {
  this.positionsArray = initialPositionsArray;
  this.currentDirection = initialDirection;
};

Snake.prototype.eat = function(food) {
  var soundToPlay = eatSound;
  this.keepLastPosition = true;
  this.increaseSpeedIfPermited();

  switch(food.type) {
  case 'goldenburger':
    this.velocity -= 0.7;
    if (this.velocity < 0.05) {
      this.velocity = 0.05
    }
    break;
  case 'sandwich':
    if (this.size() > 3) {
      this.positionsArray = this.positionsArray.slice(this.size() - 3, this.size());
    }
    break;
  case 'goldentemaki':
    //OVER NINE THOUSSSAAAAANNNDDD TEMAKIS
    soundToPlay = overNineThousandSound;
    showOverNineThousandImage();
    break;
  }

  soundToPlay.currentTime = 0;
  soundToPlay.play();


};

Snake.prototype.size = function() {
  return this.positionsArray.length;
}

// Plotando somente o ponto
Snake.prototype.draw = function() {
  var point;
  for(var i = 0; i < this.size(); i++) {
    point = this.positionsArray[i];
    point.fillStyle = this.color;
    point.draw();
  }
};
