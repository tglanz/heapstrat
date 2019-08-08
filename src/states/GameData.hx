package states;

class GameData {
    public var scene(default, null): h2d.Scene;

    public function new(scene: h2d.Scene){
        this.scene = scene;
    }
}