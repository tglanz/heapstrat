class Main extends hxd.App {

	var gameData: states.GameData;
    var statesManager: states.Core.Manager<states.GameData>;

	override function init() {
        super.init();
		
		gameData = new states.GameData(s2d);
        statesManager = new states.Core.Manager(
			gameData,
			new states.OnBoardState());
	}

	// on each frame
	override function update(dt: Float) {
        statesManager.update(dt);

		if (statesManager.isExhausted()) {
			super.dispose();
			Sys.exit(1);
		}
	}

	override function onResize() {
		super.onResize();
		statesManager.onResize();
	}

	static function main() {
        hxd.Res.initEmbed();
		new Main();
	}
}
