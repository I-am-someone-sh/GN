package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class Gameover extends FlxSubState
{
	var bg:FlxSprite;
	var re:FlxButton;
	var playing = false;

	override function create()
	{
		super.create();
		PlayState.score = 0;
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.4;
		bg.screenCenter();
		add(bg);

		re = new FlxButton(0, 0, null, restart);
		re.y += 200;
		re.scale.set(3, 3);
		re.updateHitbox();
		re.screenCenter();
		//re.text = "YOUR RESULT WAS: " + PlayState.score + "\nRETRY?";
		add(re);

		var text:FlxText = new FlxText(0, 0, 1200, "Game Over");
		text.size = 80;
		text.borderSize = 2;
		text.borderColor = FlxColor.BLACK;
		text.updateHitbox();
		text.screenCenter();
		text.y -= 200;
		text.x += 340;
		add(text);
	}

	function restart()
	{
		Menu.clicked.play();
		FlxG.switchState(new PlayState());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (re.status == 1 || re.status == 2)
			re.color = FlxColor.GRAY;
		else
			re.color = FlxColor.WHITE;

		if (re.status == 1)
		{
			if (!playing)
			{
				Menu.highlighted.play();
				playing = true;
			}
		}
		else
		{
			playing = false;
		}
	}
}
