package ;

import flash.system.System;

import openfl.events.KeyboardEvent;

class Input {
  private var arrowKeyUp:Bool;
  private var arrowKeyDown:Bool;

  public function new() {
    this.arrowKeyUp = false;
		this.arrowKeyDown = false;
  }

  public function keyUp(event:KeyboardEvent):Void {
    if (event.keyCode == 38) {        // Up
      this.arrowKeyUp = false;
    } else if (event.keyCode == 40) { // Down
      this.arrowKeyDown = false;
    }
  }

  public function keyDown(event:KeyboardEvent):Void {
    if (event.keyCode == 27) {        // Escape
      System.exit(0);
    } else if (event.keyCode == 38) { // Up
      this.arrowKeyUp = true;
    } else if (event.keyCode == 40) { // Down
      this.arrowKeyDown = true;
    }
  }

  public function isArrowKeyUp():Bool {
    return this.arrowKeyUp;
  }

  public function isArrowKeyDown():Bool {
    return this.arrowKeyDown;
  }
}
