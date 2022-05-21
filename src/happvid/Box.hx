package happvid;

import h2d.Object;
import h2d.Scene;
import h2d.col.Circle;
import Config.*;


final color_bg_content = 0x191970;
final color_txt_content = 0xAAAAAA;



class BoxContent extends h2d.Object {
	var bo:BoxObj;
	var g:h2d.Graphics;
	var itv:h2d.Interactive;

	var infos:h2d.Text;

	public function new(b:BoxObj) {
		super();
		bo = b;

		g = new h2d.Graphics(this);
		// this.rotation =0.2;
		gdraw();

		itv = new h2d.Interactive(320, 240, this);
		itv.x = -160;
		itv.y = -120;

        var bmp = new hxd.res.BitmapFont(hxd.Res.load("koulen_regular_24.fnt").entry);
		var font = bmp.toFont();
        
    //    var font = hxd.res.DefaultFont.get().clone();
    

		infos = new h2d.Text(font, this);
        infos.letterSpacing= 2;
        infos.smooth =true;
        infos.x=-160;
        infos.y=-120;
		infos.textColor = color_txt_content;
		infos.text = "Hello";
        infos.dropShadow ={dy:1,dx:1,color:0x000000,alpha:0.8};

		itv.onPush = this.onPush;
		itv.onRelease = this.onRelease;
	}

	function gdraw() {
		g.clear();
		g.beginFill(color_bg_content );
		g.drawRect(-160, -120, 320, 240);
		g.endFill();
	}

	public function text(s:String) {
		infos.text = s;
	}

	function onPush(e:hxd.Event) {
        bo.onTop();
		bo.mutil.startDrag();
	}

	function onRelease(e:hxd.Event) {
		bo.mutil.stopDrag();
	}
}

class BoxManu extends h2d.Object {
	var g:h2d.Graphics;
	var itv:h2d.Interactive;
	var bo:BoxObj;

	public function new(b:BoxObj) {
		super();
		bo = b;
		g = new h2d.Graphics(this);
		

		itv = new h2d.Interactive(400, 400, this, new Circle(0, 0, 200));
		//   itv = new h2d.Interactive(400,400,this);
		// itv.x=-200;
		// itv.y=-200;
		itv.onOver = this.onOver;
		itv.onOut = this.onOut;
		// interact.onPush =this.onPush;
		// interact.onRelease =this.onRelease;
        itv.onPush = this.onPush;
		itv.onRelease = this.onRelease;
	}

	function gdraw() {
		g.clear();
		g.beginFill(colorOver,0.2);
		g.drawCircle(0, 0, 200);
		g.endFill();
	}

	function onOver(e:hxd.Event) {
		//bo.text("BM : OVER");
        gdraw();
	}

	function onOut(e:hxd.Event) {
		//bo.text("BM : OUT");
        g.clear();
	}

    function onPush(e:hxd.Event) {
		bo.mutil.startRotScale();
	}

	function onRelease(e:hxd.Event) {
		bo.mutil.stopRotScale();
	}
}

class BoxObj extends h2d.Object {
	var content:BoxContent;
	var boxmanu:BoxManu;
    public var mutil:MUtil;

	public function new(x, y,?fixed:Bool=true) {
		super();
		this.x = x;
		this.y = y;
        rotation= 0.35;

        mutil= new MUtil(this,fixed);

		boxmanu = new BoxManu(this);
		addChild(boxmanu);

		content = new BoxContent(this);
		addChild(content);
	}

	public function update(dt:Float) {
        mutil.place();
        text("RA:"+mutil.angle()+"\nRO"+this.rotation);
 

    }

	public function text(s:String) {
		content.text(s);
	}

    public function onTop(){
        parent.addChild(this);
    }


}
