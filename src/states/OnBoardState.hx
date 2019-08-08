package states;

import h2d.Interactive;
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

class OnBoardState extends State<GameData> {

    var ui: Object;
    var header: Text;
    var start: Text;
    var exit: Text;

    var nextTransition: Transition<GameData>;

    public function new(){
    }

    private function updateLayout(scene: Scene){
        header.x = (scene.width / 2) - (header.textWidth / 2);
        header.y = Margins.Big;

        start.x = Margins.Big;
        start.y = scene.height / 2;

        exit.x = start.x;
        exit.y = start.y + start.textHeight + Margins.Normal;
    }

    public override function initialize(data: GameData) {

        ui = new Object(data.scene);

        header = new Text(DefaultFont.get(), ui);
        header.scale(TextScales.Big);
        header.text = "Heapstrat";
        header.color = Vector.fromColor(Colors.Main); // argb
        header.textAlign = Center;

        start = new Text(DefaultFont.get(), ui);
        start.scale(TextScales.Normal);
        start.text = "Start";
        start.color = Vector.fromColor(Colors.Main); // argb

        var startInteractive = new Interactive(start.textWidth, start.textHeight, start);
        startInteractive.onClick = function(event: hxd.Event){
            nextTransition = Transition.Push(new LoadState());
        }

        exit = new Text(DefaultFont.get(), ui);
        exit.scale(TextScales.Normal);
        exit.text = "Exit";
        exit.color = Vector.fromColor(Colors.Main); // argb
        
        var exitInteractive = new Interactive(exit.textWidth, exit.textHeight, exit);
        exitInteractive.onClick = function(event: hxd.Event){
            nextTransition = Transition.Pop;
        }

        updateLayout(data.scene);
    }

    public override function enter(data: GameData) {
        nextTransition = Transition.None;
        data.scene.addChild(ui);
    }

    public override function leave(data: GameData) {
        data.scene.removeChild(ui);
    }

    public override function update(data:GameData, dt:Float):Transition<GameData> {
        return nextTransition;
    }

    override function onResize(data:GameData) {
        super.onResize(data);
        updateLayout(data.scene);
    }

}