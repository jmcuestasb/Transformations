var sketch = function( p ) {
    var canvas1;
    var canvas2;
    var showMiniMap = false;

    //eye params
    var eyePosition = p.createVector(0,0);
    var eyeOrientation = 0;
    var eyeScaling = 0.5;
    
    p.setup = function() {
        p.createCanvas(700, 700);
        p.frameRate(15);
        canvas1 = p.createGraphics(p.width, p.height);
        canvas2 = p.createGraphics(p.width/2, p.height/2);
    };

    p.draw = function() {
        //p.background(0);
        canvas1.background(50);
        
        // call scene off-screen rendering on canvas 1
        scene(canvas1);
        if (showMiniMap) {
            eyePosition.x = p.mouseX;
            eyePosition.y = p.mouseY;
            drawEye();
        }
        // draw canvas onto screen
        p.image(canvas1, 0, 0);
        
        //axes(canvas1);
        //p.image(canvas1, 0, 0);
    };
    
    function scene(pg) {
        axes(pg);
        // define a local frame L1 (respect to the world)
        pg.push();
        pg.translate(400, 40);
        pg.rotate(p.QUARTER_PI / 2);
        axes(pg);
        // draw a robot in L1
        pg.fill(255, 0, 255);
        robot(pg);
        // define a local frame L2 respect to L1
        pg.push();
        pg.translate(200, 300);
        pg.rotate(-p.QUARTER_PI);
        pg.scale(2);
        axes(pg);
        // draw a house in L2
        pg.fill(0, 255, 255);
        house(pg);
        // "return" to L1
        pg.pop();
        // define a local coordinate system L3 respect to L1
        pg.push();
        pg.translate(-80, 160);
        pg.rotate(p.HALF_PI);
        pg.scale(1.5);
        axes(pg);
        // draw a robot in L3
        pg.fill(255, 255, 0);
        robot(pg);
        // return to L1
        pg.pop();
        // return to World
        pg.pop();
    };
    
    function axes(pg) {
        pg.push();
        // X-Axis
        pg.strokeWeight(4);
        pg.stroke(255, 0, 0);
        pg.fill(255, 0, 0);
        pg.line(0, 0, 100, 0);
        pg.text("X", 100 + 5, 0);
        // Y-Axis
        pg.stroke(0, 0, 255);
        pg.fill(0, 0, 255);
        pg.line(0, 0, 0, 100);
        pg.text("Y", 0, 100 + 15);
        pg.pop();
    };
    
    //taken from: https://processing.org/tutorials/transform2d/
    function robot(pg) {
        pg.push();
        pg.noStroke();
        pg.rect(20, 0, 38, 30); // head
        pg.rect(14, 32, 50, 50); // body
        pg.rect(0, 32, 12, 37); // left arm
        pg.rect(66, 32, 12, 37); // right arm
        pg.rect(22, 84, 16, 50); // left leg
        pg.rect(40, 84, 16, 50); // right leg
        pg.fill(222, 222, 249);
        pg.ellipse(30, 12, 12, 12); // left eye
        pg.ellipse(47, 12, 12, 12); // right eye
        pg.pop();
    }

    //taken from: https://processing.org/tutorials/transform2d/
    function house(pg) {
        pg.push();
        pg.triangle(15, 0, 0, 15, 30, 15);
        pg.rect(0, 15, 30, 30);
        pg.rect(12, 30, 10, 15);
        pg.pop();
    };
};

var p5_mm = new p5(sketch, 'minimap_id');
