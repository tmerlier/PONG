package ;

import openfl.display.Sprite;
import openfl.geom.Point;

enum Side {
	Left;
	Right;
	Center;
}

class Ball extends Sprite {
	private var movement:Point;
	private var speed:Int;

	public function new() {
		super();

		this.graphics.beginFill(0xffffff);
		this.graphics.drawCircle(0, 0, 10);
		this.graphics.endFill();

		// Init Position
		this.setPositions(250, 250);

		this.speed = 7;
		this.movement = new Point(0, 0);
	}

	public function setPositions( x:Int, y:Int ) : Void {
		this.x = x;
		this.y = y;
	}

	public function move() : Void {
		this.x += this.movement.x;
		this.y += this.movement.y;
	}

	public function launch() : Void {
		this.setPositions(250, 250);
		var direction:Int = (Math.random() > .5) ? 1 : -1;
		var randomAngle:Float = (Math.random() * Math.PI / 2) - 45;

		this.movement.x = direction * Math.cos(randomAngle) * this.speed;
		this.movement.y = Math.sin(randomAngle) * this.speed;
	}

	public function bounce() : Void {
		var direction:Int = (this.movement.x > 0)?( -1):(1);
		var randomAngle:Float = (Math.random() * Math.PI / 2) - 45;

		this.movement.x = direction * Math.cos(randomAngle) * this.speed;
		this.movement.y = Math.sin(randomAngle) * this.speed;
	}

	public function edgeBounce() : Void {
		this.movement.y *= -1;
	}

	public function side() : Side {
		if( this.movement.x < 0 && this.x < 30 ) {
			return Left;
		} else if( this.movement.x > 0 && this.x > 470 ) {
			return Right;
		} else {
			return Center;
		}
	}

}
