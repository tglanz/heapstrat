package states;

import h2d.Scene;
import h2d.Text;
import h2d.Object;

import Theme.Margins;
import Theme.TextScales;
import Theme.Colors;

import h3d.Vector;
import hxd.res.DefaultFont;
import states.Core;
import states.GameData;

class LoadState extends State<GameData> {

    var ui: Object;
    var header: Text;

    var lastEnterTime: Float;
    
    public function new(){
    }

    private function updateLayout(scene: Scene){
        header.x = (scene.width / 2) - (header.textWidth / 2);
        header.y = Margins.Big;
    }

    public override function initialize(data: GameData) {

        ui = new Object(data.scene);

        header = new Text(DefaultFont.get(), ui);
        header.scale(TextScales.Big);
        header.text = "Load";
        header.color = Vector.fromColor(Colors.Main); // argb
        header.textAlign = Center;

        updateLayout(data.scene);
    }

    public override function enter(data: GameData) {
        lastEnterTime = Date.now().getTime();
        data.scene.addChild(ui);
    }

    public override function leave(data: GameData) {
        data.scene.removeChild(ui);
    }

    public override function update(data:GameData, dt:Float): Transition<GameData> {
        var nowTime = Date.now().getTime();
        if (nowTime - lastEnterTime > 10000){
            return Transition.Pop;
        }

        return Transition.None;
    }

    override function onResize(data:GameData) {
        super.onResize(data);
        updateLayout(data.scene);
    }

}