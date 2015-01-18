// Plotando somente o ponto
Snake.prototype.draw = function() {
  var point;
  for(var i = 0; i < this.size(); i++) {
    point = this.positionsArray[i];
    point.fillStyle = this.color;
    point.draw();
  }
};

// Agora quero plotar um corpo
Snake.prototype.draw = function() {
  var point;
  for(var i = 0; i < this.size(); i++) {
    point = this.positionsArray[i];
    if (i == this.size() - 1) {
      ctx.drawImage(this.headImage[this.currentDirection], point.x*GRID_UNIT_SIZE, point.y*GRID_UNIT_SIZE);
    } else {
      ctx.drawImage(this.bodyImage, point.x*GRID_UNIT_SIZE, point.y*GRID_UNIT_SIZE);
      this.bodyImage; // WTF?
    }
  }
};
