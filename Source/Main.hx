package ;

import ScoreBoard.Player;
import Ball.Side;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.events.KeyboardEvent;

enum GameState {
	Paused;
	Playing;
}

class Main extends Sprite
{
	var inited:Bool;

	private var menu:Menu;

	private var platform1:Platform;
	private var platform2:Platform;
	private var ball:Ball;
	private var scoreBoard:ScoreBoard;
	private var pause:Pause;
	private var currentGameState:GameState;
	private var platformSpeed:Int;
	private var input:Input;

	/* ENTRY POINT */

	function resize(e) {
		if (!inited) init();
		// else (resize or orientation change)
	}

	function init() {
		if (inited) return;
		inited = true;

		pause = new Pause(stage);
		setGameState(Paused);

		platform1 = new Platform();
		platform1.setPositions(5, 200);

		platform2 = new Platform();
		platform2.setPositions(480, 200);

		ball = new Ball();

		scoreBoard = new ScoreBoard();

		input = new Input();

		reinitStage();

		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		this.addEventListener(Event.ENTER_FRAME, everyFrame);
	}

	private function setGameState(state:GameState):Void {
		currentGameState = state;
		if (state == Paused) {
			pause.display(true);
		} else {
			pause.display(false);
			this.reinitStage();
		}
	}

	private function reinitStage():Void {
		platform1.moveTo(200);
		platform2.moveTo(200);

		this.addChild(platform1);
		this.addChild(platform2);
		this.addChild(ball);
		this.addChild(scoreBoard.scoreField);

		ball.launch();
	}

	private function keyUp(event:KeyboardEvent):Void {
		input.keyUp(event);
	}

	private function keyDown(event:KeyboardEvent):Void {
		if (currentGameState == Paused && event.keyCode == 32) { // Space
			setGameState(Playing);
		} else {
			input.keyDown(event);
		}
	}

	private function everyFrame(event:Event):Void {
		if (currentGameState == Playing) {
			// player platform movement
			if (input.isArrowKeyUp()) {
				platform1.moveUp();
			}
			if (input.isArrowKeyDown()) {
				platform1.moveDown();
			}

			// AI2 platform movement
			if (ball.x > 300 && ball.y > platform2.y + 70) {
				platform2.moveDown();
			}
			if (ball.x > 300 && ball.y < platform2.y + 30) {
				platform2.moveUp();
			}

			// ball movement
			ball.move();

			// ball platform bounce
			if (ball.side() == Side.Left && platform1.isHit(ball)) {
				ball.bounce();
				ball.x = 30;
			}
			if (ball.side() == Side.Right && platform2.isHit(ball)) {
				ball.bounce();
				ball.x = 470;
			}

			// ball edge bounce
			if (ball.y < 5 || ball.y > 495) {
				ball.edgeBounce();
			};

			// ball goal
			if (ball.x < 5) winGame(Player.AI);
			if (ball.x > 495) winGame(Player.Human);
		}
	}

	private function winGame(player:Player):Void {
		scoreBoard.increase(player);
		setGameState(Paused);
	}

	/* SETUP */

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) {
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}

	public static function main() {
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
		//
	}
}
