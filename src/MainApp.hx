package;

import happvid.Box.BoxObj;
import happvid.*;


class  MainApp  extends hxd.App {

 
    var world:happvid.World;
    var infos:h2d.Text;

    var bo:BoxObj;
    var boo:BoxObj;
 

    override  function  init() {

        hxd.Res.initEmbed();
       // hxd.Window.getInstance().addResizeEvent(this.onResize);
        world= new World();
        infos = new h2d.Text(hxd.res.DefaultFont.get());
        infos.text = "Hello";
        s2d.scaleMode = Resize;
        s2d.addChild(world);
        s2d.addChild(infos);

        bo =new BoxObj(600,500,false);
        boo =new BoxObj(200,500);
        
        world.addChild(boo);
        world.addChild(bo);
        

    }

    override function update(dt:Float) {
        var w = hxd.Window.getInstance().width;
		var h = hxd.Window.getInstance().height;
        //infos.text="Size :"+w+" X "+h;
     
        world.update(dt);
        bo.update(dt);
        boo.update(dt);
      
        
    }

    override function onResize() {
        super.onResize();
        var w = hxd.Window.getInstance().width;
		var h = hxd.Window.getInstance().height;
        infos.text="Size :"+w+" X "+h;
        
        world.resize();
        
    }


    public static var inst : MainApp;

    static  function  main() {
        inst=new  MainApp();
    }
  }