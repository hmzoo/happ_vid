package happvid;



class World extends h2d.Scene {

	var background: Background;
	

	public function new() {
		super();
		this.scaleMode =Resize;
		background = new Background(this);
	}



	public function redraw() {
	
	}

	public function resize() {
		trace(this.width,this.height);
	
	}



	public function update(dt:Float) {
        redraw();
    }
}