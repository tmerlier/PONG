package ;
import openfl.display.Sprite;

class Platform extends Sprite
{
	private var speed:Int;

	public function new()
	{
		super();

		this.speed = 7;

		this.graphics.beginFill(0xffffff);
		this.graphics.drawRect(0, 0, 15, 100);
		this.graphics.endFill();
	}

	public function setPositions(x:Int, y:Int):Void {
		this.x = x;
		this.y = y;
	}

	public function isHit( ball:Ball ) : Bool {
		if (ball.y >= this.y && ball.y <= this.y + 100) {
			return true;
		}
		return false;
	}

	public function moveTo( y:Int ):Void {
		if (y > 395) y = 395;
		this.y = y;
	}

	public function moveUp():Void {
		this.y -= this.speed;
		if (this.y < 5) this.y = 5;
	}

	public function moveDown():Void {
		this.y += this.speed;
		if (this.y > 395) this.y = 395;
	}
}
