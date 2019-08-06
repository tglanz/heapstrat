import hxd.App;
import hxd.res.DefaultFont;

class Main extends App {

    override function init() {
        // create a text component, and add it to the 2d scene (s2d)
        var tf = new h2d.Text(DefaultFont.get(), s2d);
        tf.text = "Hi!";
    }

    static function main() {
        new Main();
    }
}