package;
import flixel.FlxSprite;
class Black extends FlxSprite {
    public function new() {
        super();
        loadGraphic('assets/Glow.png');
		screenCenter(Y);
		y += 20;
		x = 1290;
		updateHitbox();
    }
}