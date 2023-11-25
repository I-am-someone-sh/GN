package;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;
class Player extends FlxSprite {
    var fps = 24; //fvv没吃药做的
	var delay:FlxTimer;
    var sec:Float = 0.15;

    public function new() {
        super();
	    frames = FlxAtlasFrames.fromSparrow('assets/cha.png', 'assets/cha.xml');
		animation.addByPrefix('idle', 'idle', fps);
		animation.addByPrefix('left', 'left', fps);
		animation.addByPrefix('right', 'right', fps);
		screenCenter();
		animation.play('idle');
		animation.finishCallback = animback;
		x -= 8;
        y += 70;
    }
    function back(timer):Void
    {
        animback("right");
    }
    function animback(sup) {
        if (sup != "idle"){
            animation.stop();
            animation.play("idle");
        }
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        if (FlxG.keys.anyJustPressed([LEFT, A]))
            {
                animation.play('left');
                delay = new FlxTimer().start(sec, back); // 0.24
            }
            if (FlxG.keys.anyJustPressed([RIGHT, D]))
            {
                animation.play('right');
                delay = new FlxTimer().start(sec, back);
            }
    }
}