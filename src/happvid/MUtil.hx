package happvid;

class MUtil {
    public var obj: h2d.Object;
	public var drag:Bool;
    public var rot:Bool;
    public var scale:Bool;
    public var fixed:Bool;
    
	public var dx:Float;
	public var dy:Float;
    public var ds:Float;
    public var dr:Float;
    public var ox:Float;
    public var oy:Float;
    public var os:Float;
    public var or:Float;

	public function new(o: h2d.Object,fix:Bool) {

        obj =o;
		drag = false;
        rot = false;
        scale = false;
        fixed= fix;
       
		dx = 0;
		dy = 0;
        ds= 0;
        dr= 0;

        ox=obj.x;
        oy=obj.y;
        or=obj.rotation;
        os=obj.scaleX;
	}

    public function startRotScale(){
        rot=true;
        dr = angle()-obj.rotation;
        scale= true;
        ds = distance()/obj.scaleX;
        
    }

    public function stopRotScale(){
       rot=false;
       scale = false;
       dr=0;
       ds=1;
       fix();
    }

    public function startDrag(){
        drag=true;
        dx=obj.getScene().mouseX-obj.x;
        dy=obj.getScene().mouseY-obj.y;
    }

    public function stopDrag(){
        drag=false;
        dx=0;
        dy=0;
        fix();
        
    }

    public function go(x,y,r,s){
        ox=x;
        oy=y;
        or=r;
        os=s;
    }

    public function fix(){
        if(!fixed){
        ox=obj.x;
        oy=obj.y;
        or=obj.rotation;
        os=obj.scaleX;
        }
    }

    public function place(){
        if(drag){
            obj.x=obj.getScene().mouseX-dx;
            obj.y=obj.getScene().mouseY-dy;
        }
        if(rot){
            obj.rotation= angle()-dr;
        }
        if(scale){
            if (ds > 0.5){
            obj.scaleX=distance()/ds;
            obj.scaleY=obj.scaleX;
            }
        }
        if(!(drag || rot || scale)){
            if(Math.abs(obj.x-ox)<0.5){
                obj.x= ox;
            }else{
                obj.x=obj.x+(ox-obj.x)/10;
            }
            if(Math.abs(obj.y-oy)<0.5){
                obj.y= oy;
            }else{
                obj.y=obj.y+(oy-obj.y)/10;
            }
            if(Math.abs(obj.rotation-or)<0.1){
                obj.rotation=or;
            }else{
                obj.rotation=obj.rotation+(or-obj.rotation)/10;
            }
            if(Math.abs(obj.scaleX-os)<0.05){
                obj.scaleX=os;
                obj.scaleY=os;
            }else{
                obj.scaleX=obj.scaleX+(os-obj.scaleX)/10;
                obj.scaleY=obj.scaleX;
            }
        }
    }

    public function angle() :Float {
        return hxd.Math.atan2(obj.getScene().mouseY-obj.y, obj.getScene().mouseX-obj.x);
    }

    public function distance() :Float {
        return hxd.Math.distance(obj.getScene().mouseY-obj.y, obj.getScene().mouseX-obj.x);
    }
}