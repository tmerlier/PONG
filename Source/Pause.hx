package ;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

class Pause {
  private var messageField = new TextField();

  public function new(stage) {
    var messageFormat:TextFormat = new TextFormat("Verdana", 18, 0xbbbbbb, true);
    messageFormat.align = TextFormatAlign.CENTER;

    messageField.width = 500;
    messageField.y = 400;
    messageField.defaultTextFormat = messageFormat;
    messageField.selectable = false;
    messageField.text = "Press SPACE to start\nUse ARROW KEYS to move your platform";

    stage.addChild(messageField);
  }

  public function display(show:Bool):Void {
    if (show) {
      messageField.alpha = 1;
    } else {
      messageField.alpha = 0;
    }
  }
}
