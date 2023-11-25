package;
import flixel.system.FlxSplash;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;

import Black;
import White;
import Player;

class PlayState extends FlxState
{
	var hit:FlxSprite;
	var start = false;
	var rng:Int = 7; // random number generator(real)
	var data:Float = 1200;
	var stop = false;
	var test:FlxText;
	var sb:FlxSprite;
	//var delay:FlxTimer;
	var ready:FlxTimer;
	public static var score:Int;
	public static var highscore:Int;
	var hitboxX:Float;
	var playerHitbox:FlxSprite; // just like scratch lol, also don't ask why I add a hitbox because frame broken
	var scoreText:FlxText;
	var bl:Bool;
	
	var player:Player;
	var sp:FlxSprite;
	var white:White;
	var bg:FlxSprite;
	var black:Black;
	var white2:White;
	var black2:Black;

	override function create()
	{
		super.create();

		hit = new FlxSprite(0, 0);
		hit.frames = FlxAtlasFrames.fromSparrow('assets/hitStuff/hitEff.png', 'assets/hitStuff/hitEff.xml');
		hit.animation.addByPrefix('hit it', 'hit it', 30);
		hit.animation.finishCallback = invisible;
		hit.visible = false;

		bg = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);

		playerHitbox = new FlxSprite(0, 0);
		playerHitbox.makeGraphic(30, 160, FlxColor.BLACK); // 117 184 Hitbox so small UwU
		playerHitbox.screenCenter();
		playerHitbox.immovable = true;
		playerHitbox.moves = false;
		hitboxX = playerHitbox.x;
		playerHitbox.visible = false;

		test = new FlxText(0, 0, 300, 'amogus'); // 测试用的, 因为网页用不了trace。
		test.screenCenter();
		test.size = 20;
		test.color = flixel.util.FlxColor.BLACK;
		test.alignment = LEFT;
		// add(test);

		sb/*不是那个sb啊, 是scoreboard*/ = new FlxSprite(0, 0).loadGraphic('assets/scoreboard.png');
		sb.scale.set(1.2,1.2);
		sb.updateHitbox();
		sb.screenCenter(Y);
		sb.y -= 200;
	
		scoreText = new FlxText(0, 0, 120, Std.string(score), 50);
		scoreText.color = FlxColor.WHITE;
		scoreText.borderStyle = FlxTextBorderStyle.OUTLINE;
		scoreText.bold = true;
		scoreText.borderColor = FlxColor.WHITE;
		scoreText.borderSize = 1.25;
		scoreText.alignment = LEFT;
		scoreText.screenCenter(Y);
		scoreText.y -= 195;
		scoreText.x += 110;
		scoreText.updateHitbox();

		player = new Player();
		black = new Black();
		white = new White();
		black2 = new Black();
		white2 = new White();

		add(bg);
		add(white);
		add(black);
		add(white2);
		add(black2);
		add(playerHitbox);
		add(player);
		add(sb);
		add(scoreText);
		add(hit);
		ready = new FlxTimer().start(0.35, go);
	}
	function invisible(_) {
		hit.visible = false;
	}
	function go(_)
	{
		rng = FlxG.random.int(0, 1);
		bl = FlxG.random.bool(50);
	}
	function tryToDo(?gameover:Bool) {
		start = true;
		if(!gameover || gameover == null){
		score += 1;
		hit.visible = true;
		hit.animation.play('hit it');
		FlxG.sound.play('assets/sounds/hit.wav', 1, false, null, false);
		FlxG.sound.play('assets/sounds/goback.wav');
		}
		else{
			name();
			hit.visible = true;
			FlxG.sound.play('assets/sounds/GameOver.wav');
			openSubState(new Gameover());
		}
	} 
	function name() {
		FlxG.save.bind('GameData', 'Seven-Flixel-GameData');
		FlxG.save.data.score = score;
		FlxG.save.flush();
	}
	function trying(black:FlxSprite, player:FlxSprite)
	{
		if (test.text == 'right') //I have to
		{
			black.velocity.x = data + 1400 - 500;
			hit.x = black.x;
			hit.y = black.y;
			tryToDo();
		}
		else
		{
			hit.x = black.x;
			hit.y = black.y;
			tryToDo(true);
		}
	}

	function tryingw(white:FlxSprite, player:FlxSprite)
	{
		if (test.text == 'left')
		{
			white.velocity.x = -(data + 1400);
			hit.x = white.x;
			hit.y = white.y;
			tryToDo();
		}
		else
		{
			hit.x = white.x;
			hit.y = white.y;
			tryToDo(true);
		}
	}


	function trying2(black2:FlxSprite, player:FlxSprite)
		{
			if (test.text == 'right') //I have to
			{
				black2.velocity.x = data + 1400 - 500;
				hit.x = black2.x;
				hit.y = black2.y;
				tryToDo();
			}
			else
			{
				hit.x = black2.x;
				hit.y = black2.y;
				tryToDo(true);
			}
		}
	
		function tryingw2(white2:FlxSprite, player:FlxSprite)
		{
			if (test.text == 'left')
			{
				white2.velocity.x = -(data + 1400);
				hit.x = white2.x;
				hit.y = white2.y;
				tryToDo();
			}
			else
			{
				hit.x = white2.x;
				hit.y = white2.y;
				tryToDo(true);
			}
		}


	override function update(elapsed:Float)
	{
		test.text = player.animation.name;
		FlxG.collide(black, playerHitbox, trying);
		FlxG.collide(white, playerHitbox, tryingw);
		FlxG.collide(black2, playerHitbox, trying2);
		FlxG.collide(white2, playerHitbox, tryingw2);
		super.update(elapsed);
		if (score > 9){
			scoreText.x = 95;
		}
		scoreText.text = Std.string(score);
		if (FlxG.keys.justPressed.ESCAPE)
		{
			Menu.esc.play();
			name();
			FlxG.switchState(new Menu());
		}
		switch(player.animation.name){
			case "left":
				playerHitbox.x = hitboxX - 50;
			case "right":
				playerHitbox.x = hitboxX + 50;
			case "idle":
				playerHitbox.x = hitboxX;
		}
		switch(rng){
			case 0:
				rng = 3;
				white.velocity.x = FlxG.random.float(data + 70, data + 150);
				if (bl){
				white2.velocity.x = FlxG.random.float(data - 320, data - 260);
				}
			case 1:
				rng = 3;
				black.velocity.x = -(FlxG.random.float(data + 200, data + 250));
				if (bl){
				black2.velocity.x = -(FlxG.random.float(data - 250, data - 400));
				}
			}
		if(bl){
			if (black.x > 1290 && black2.x > 1290)
			{
				FlxG.switchState(new PlayState());
			}
			if (white.x < -150 && white2.x < -150)
			{
				FlxG.switchState(new PlayState());
			}
		}
		else if(!bl){
			if (black.x > 1290)
				{
					FlxG.switchState(new PlayState());
				}
				if (white.x < -150)
				{
					FlxG.switchState(new PlayState());
				}
		}
	}
}
