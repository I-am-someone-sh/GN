package;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
class Menu extends FlxState{
    var game:FlxButton;
    var playing:Bool = false;
	var blackScreen:FlxSprite;
	var yt:FlxButton;
    public static var clicked:FlxSound;
    public static var esc:FlxSound;
	public static var highlighted:FlxSound;
	var scoreText:FlxText;
	var highscore:Int;
    override function create() {
		super.create();

		var sb/*不是那个sb啊, 是scoreboard*/ = new FlxSprite().loadGraphic('assets/scoreboard.png');
		sb.scale.set(1.2,1.2);
		sb.updateHitbox();
		sb.screenCenter(Y);
		sb.y -= 200;

		PlayState.score = 0;
        clicked = new FlxSound();
        clicked.loadEmbedded('assets/sounds/button_clicked.wav', false, false);
		esc = new FlxSound();
		esc.loadEmbedded('assets/sounds/escape_clicked.wav', false, false);
        highlighted = new FlxSound();
		highlighted.loadEmbedded('assets/sounds/button_highlighted.wav', false, false, uCantPlay);
        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
        add(bg);
        game = new FlxButton(0, 0, null, load_screen);
        game.scale.set(3, 3);
		game.updateHitbox();
        game.screenCenter();
		//game.text = "Start";
        add(game);


		yt = new FlxButton(0, 0, null, goURL);
		yt.loadGraphic('assets/youtube.png');
		yt.scale.set(0.7, 0.7);
		yt.updateHitbox();
		yt.screenCenter();
		yt.y += 200;
		yt.x = 0;

		scoreText = new FlxText(0, 0, 120, Std.string(highscore), 50);
		scoreText.screenCenter(Y);
		scoreText.color = FlxColor.WHITE;
		scoreText.alignment = LEFT;
		scoreText.y -= 195;
		scoreText.x += 90;
		scoreText.borderStyle = FlxTextBorderStyle.OUTLINE;
		scoreText.bold = true;
		scoreText.borderColor = FlxColor.WHITE;
		scoreText.borderSize = 1.25;

		add(yt);
		//add(scoreText);
		//add(sb);
    }
	function load_screen() {
		clicked.play();
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.x = -FlxG.width;
		blackScreen.alpha = 0;
		add(blackScreen);
		FlxTween.tween(blackScreen, {x: 0}, 1, {ease: FlxEase.quadInOut, onComplete: preStart});
		FlxTween.tween(blackScreen, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
		scoreText.y = 1300;
		yt.y = 1300;
		game.y = 1300;
	}
	function uCantPlay() {
		playing = true;
    }
	function goURL() {
		clicked.play();
		FlxG.openURL('https://www.youtube.com/@SevenHill810');
	}
    function preStart(_) {
		var ready = new FlxTimer().start(0.75, go);
    }
	function go(_) {
		FlxG.switchState(new FakeStart());
	}
    override function update(elapsed:Float) {
        super.update(elapsed);
		//scoreText.text = Std.string();
        if (game.status == 1 || game.status == 2){game.color = FlxColor.GRAY;}
        else {game.color = FlxColor.WHITE;}

		if (yt.status == 1 || yt.status == 2)
		{
			yt.color = FlxColor.GRAY;
		}
		else
		{
			yt.color = FlxColor.WHITE;
		}

		if (game.status == 1 || yt.status == 1)
		{
			if (!playing)
			{
				highlighted.play();
				playing = true; //what is this meaning for? make sure.
			}
		}
		else
		{
			playing = false;
		}
    }
}
class FakeStart extends PlayState{
	var blackScreen:FlxSprite;
	override function create() {
		super.create();
		ready.cancel();
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.x = 0;
		blackScreen.alpha = 1;
		add(blackScreen);
		new FlxTimer().start(0.3, aFunc);
	}
	function aFunc(_) {
		FlxTween.tween(blackScreen, {alpha: 0}, {ease: FlxEase.quartOut, onComplete: switchState});
	}
	function switchState(_) {
		FlxG.switchState(new PlayState());
	}
}
