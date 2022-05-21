package happvid;

class Background extends h2d.Object {

    var img:h2d.Bitmap;

    public function new(scene : h2d.Scene) {
		super(scene);
		
		//img = new h2d.Bitmap(h2d.Tile.fromColor(Config.colorBackground, scene.width, scene.height), this);
        img = new h2d.Bitmap(hxd.Res.load("background.jpg").toImage().toTile(), this);
	}

    public function show(){
        addChild(img);
    }
}