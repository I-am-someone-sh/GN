package;
import flixel.FlxSprite;
class White extends FlxSprite {
    public function new() {
        super();
        loadGraphic('assets/Glow.png');
		screenCenter(Y);
		y += 20;
		x = -150;
		updateHitbox();
		flipX = true;
    }
}