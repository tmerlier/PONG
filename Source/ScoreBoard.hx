package ;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

enum Player {
  Human;
  AI;
}

class ScoreBoard {

  private var scorePlayer:Int;
	private var scoreAI:Int;

  public var scoreField = new TextField();
  public var scoreFormat:TextFormat = new TextFormat("Verdana", 24, 0xbbbbbb, true);

  public function new() {
    scoreField.width = 500;
    scoreField.y = 30;
    scoreFormat.align = TextFormatAlign.CENTER;
    scoreField.defaultTextFormat = scoreFormat;
    scoreField.selectable = false;

    scorePlayer = 0;
    scoreAI = 0;

    this.updateScore();
  }

  public function increase(player:Player):Void {
    if (player == Human) {
      scorePlayer++;
    } else {
      scoreAI++;
    }

    this.updateScore();
  }

  private function updateScore():Void {
    scoreField.text = scorePlayer + ":" + scoreAI;
  }
}
