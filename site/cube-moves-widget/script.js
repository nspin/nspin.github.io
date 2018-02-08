function rotCube() {
    segs = "rotateX(" + cubex + "deg) rotateY(" + cubey + "deg) rotateZ(" + cubez + "deg) translateX(0) translateY(0) translateZ(0)";
    $(".cube").css({
        transform: segs
    });
}

function kiir() {
    var r = "";
    for (var i = 1; 55 > i; i++) {
        r = r + '<div class="field mezo mezo' + i + " szine" + a[i] + '"><span>' + i + "</span></div>";
    }
    document.getElementById("cubeFields").innerHTML = r
}

function kiirRotLayer(r, e) {
    var o = "";
    var t = "";
    for (var i = 0; i < r.length; i++) {
        t = "#cubeFields .mezo" + r[i];
        $(t).hide();
        o = o + '<div class="layer mezo mezo' + r[i] + " szine" + a[r[i]] + '"><span>' + r[i] + "</span></div>";
    }
    7 > e && (o = o + '<div class="core core' + e + '"></div>', document.getElementById("cubeFields").innerHTML = document.getElementById("cubeFields").innerHTML + '<div class="core core' + e + '"></div>');
    7 == e && (o += '<div class="core core2"></div><div class="core core4"></div>', document.getElementById("cubeFields").innerHTML = document.getElementById("cubeFields").innerHTML + '<div class="core core2"></div><div class="core core4"></div>');
    8 == e && (o += '<div class="core core1"></div><div class="core core6"></div>', document.getElementById("cubeFields").innerHTML = document.getElementById("cubeFields").innerHTML + '<div class="core core1"></div><div class="core core6"></div>');
    9 == e && (o += '<div class="core core3"></div><div class="core core5"></div>', document.getElementById("cubeFields").innerHTML = document.getElementById("cubeFields").innerHTML + '<div class="core core3"></div><div class="core core5"></div>');
    document.getElementById("rotLayer").innerHTML = o;
}

function initnotscrambled() {
    a[0] = 0;
    for (var j = 0; 6 > j; j++) {
        for (var i = 1; 10 > i; i++) {
            a[i + 9 * j] = j + 1;
            kiir();
        }
    }
}

function facerotate(a) {
    setTimeout(function() {
        11 == a && $("#rotLayer").css("transform", "rotatey(" + -(10 * counter) + "deg)");
        12 == a && $("#rotLayer").css("transform", "rotatey(" + 10 * counter + "deg)");
        21 == a && $("#rotLayer").css("transform", "rotatex(" + -(10 * counter) + "deg)");
        22 == a && $("#rotLayer").css("transform", "rotatex(" + 10 * counter + "deg)");
        31 == a && $("#rotLayer").css("transform", "rotatez(" + 10 * counter + "deg)");
        32 == a && $("#rotLayer").css("transform", "rotatez(" + -(10 * counter) + "deg)");
        41 == a && $("#rotLayer").css("transform", "rotatex(" + 10 * counter + "deg)");
        42 == a && $("#rotLayer").css("transform", "rotatex(" + -(10 * counter) + "deg)");
        51 == a && $("#rotLayer").css("transform", "rotatez(" + 10 * -counter + "deg)");
        52 == a && $("#rotLayer").css("transform", "rotatez(" + 10 * counter + "deg)");
        61 == a && $("#rotLayer").css("transform", "rotatey(" + 10 * counter + "deg)");
        62 == a && $("#rotLayer").css("transform", "rotatey(" + -(10 * counter) + "deg)");
        71 == a && $("#rotLayer").css("transform", "rotatex(" + -(10 * counter) + "deg)");
        72 == a && $("#rotLayer").css("transform", "rotatex(" + 10 * counter + "deg)");
        81 == a && $("#rotLayer").css("transform", "rotatey(" + 10 * counter + "deg)");
        82 == a && $("#rotLayer").css("transform", "rotatey(" + -(10 * counter) + "deg)");
        91 == a && $("#rotLayer").css("transform", "rotatez(" + 10 * counter + "deg)");
        92 == a && $("#rotLayer").css("transform", "rotatez(" + -(10 * counter) + "deg)");
        101 == a && $("#rotLayer").css("transform", "rotatex(" + 10 * counter + "deg)");
        102 == a && $("#rotLayer").css("transform", "rotatex(" + -(10 * counter) + "deg)");
        111 == a && $("#rotLayer").css("transform", "rotatey(" + -(10 * counter) + "deg)");
        112 == a && $("#rotLayer").css("transform", "rotatey(" + 10 * counter + "deg)");
        121 == a && $("#rotLayer").css("transform", "rotatez(" + 10 * counter + "deg)");
        122 == a && $("#rotLayer").css("transform", "rotatez(" + -(10 * counter) + "deg)");
        counter++;
        10 > counter ? facerotate(a) : (
            document.getElementById("rotLayer").innerHTML = "",
            $("#rotLayer").css("transform", "rotatey(0deg)"),
            kiir(),
            counter = 0
        );
    }, speed);
}

function turn(a) {
    0 == counter && ("U" == a && (kiirRotLayer(layeru, 1), facerotate(11), uu()), "u" == a && (kiirRotLayer(layeru, 1), facerotate(12), ui()), "R" == a && (kiirRotLayer(layerr, 4), facerotate(41), rr()), "r" == a && (kiirRotLayer(layerr, 4), facerotate(42), ri()), "D" == a && (kiirRotLayer(layerd, 6), facerotate(61), dd()), "d" == a && (kiirRotLayer(layerd, 6), facerotate(62), di()), "F" == a && (kiirRotLayer(layerf, 3), facerotate(31), ff()), "f" == a && (kiirRotLayer(layerf, 3), facerotate(32), fi()), "B" == a && (kiirRotLayer(layerb, 5), facerotate(51), bb()), "b" == a && (kiirRotLayer(layerb, 5), facerotate(52), bi()), "L" == a && (kiirRotLayer(layerl, 2), facerotate(21), ll()), "l" == a && (kiirRotLayer(layerl, 2), facerotate(22), li()), "U2" == a && (kiirRotLayer(layeru2, 6), facerotate(11), uu(), dd(), ui(), fd()), "u2" == a && (kiirRotLayer(layeru2, 6), facerotate(12), ui(), di(), uu(), fd(), fd(), fd()), "R2" == a && (kiirRotLayer(layerr2, 2), facerotate(41), rr(), bor(), bor(), bor(), ri(), ll()), "r2" == a && (kiirRotLayer(layerr2, 2), facerotate(42), ri(), bor(), rr(), li()), "D2" == a && (kiirRotLayer(layerd2, 1), facerotate(61), dd(), di(), uu(), fd(), fd(), fd()), "d2" == a && (kiirRotLayer(layerd2, 1), facerotate(62), di(), dd(), ui(), fd()), "F2" == a && (kiirRotLayer(layerf2, 5), facerotate(31), ff(), fi(), bb(), fd(), bor(), fd(), fd(), fd()), "f2" == a && (kiirRotLayer(layerf2, 5), facerotate(32), fi(), ff(), bi(), fd(), fd(), fd(), bor(), fd()), "B2" == a && (kiirRotLayer(layerb2, 3), facerotate(51), bb(), ff(), bi(), fd(), fd(), fd(), bor(), fd()), "b2" == a && (kiirRotLayer(layerb2, 3), facerotate(52), bi(), fi(), bb(), fd(), bor(), fd(), fd(), fd()), "L2" == a && (kiirRotLayer(layerl2, 4), facerotate(21), ll(), bor(), rr(), li()), "l2" == a && (kiirRotLayer(layerl2, 4), facerotate(22), li(), bor(), bor(), bor(), ri(), ll()), "X" == a && (kiirRotLayer(wholecube, 99), facerotate(101), bor(), bor(), bor()), "x" == a && (kiirRotLayer(wholecube, 99), facerotate(102), bor()), "Y" == a && (kiirRotLayer(wholecube, 99), facerotate(111), fd()), "y" == a && (kiirRotLayer(wholecube, 99), facerotate(112), fd(), fd(), fd()), "Z" == a && (kiirRotLayer(wholecube, 99), facerotate(121), fd(), bor(), fd(), fd(), fd()), "z" == a && (kiirRotLayer(wholecube, 99), facerotate(122), fd(), fd(), fd(), bor(), fd()), "M" == a && (kiirRotLayer(layerm, 7), facerotate(71), bor(), rr(), li()), "m" == a && (kiirRotLayer(layerm, 7), facerotate(72), bor(), bor(), bor(), ri(), ll()), "E" == a && (kiirRotLayer(layere, 8), facerotate(81), di(), uu(), fd(), fd(), fd()), "e" == a && (kiirRotLayer(layere, 8), facerotate(82), dd(), ui(), fd()), "S" == a && (kiirRotLayer(layers, 9), facerotate(91), fi(), bb(), fd(), bor(), fd(), fd(), fd()), "s" == a && (kiirRotLayer(layers, 9), facerotate(92), ff(), bi(), fd(), fd(), fd(), bor(), fd()))
}

function bor() {
    s[1] = a[1], s[2] = a[4], s[3] = a[7], a[1] = a[45], a[4] = a[42], a[7] = a[39], a[45] = a[46], a[42] = a[49], a[39] = a[52], a[46] = a[19], a[49] = a[22], a[52] = a[25], a[19] = s[1], a[22] = s[2], a[25] = s[3], s[1] = a[2], s[2] = a[5], s[3] = a[8], a[2] = a[44], a[5] = a[41], a[8] = a[38], a[44] = a[47], a[41] = a[50], a[38] = a[53], a[47] = a[20], a[50] = a[23], a[53] = a[26], a[20] = s[1], a[23] = s[2], a[26] = s[3], s[1] = a[3], s[2] = a[6], s[3] = a[9], a[3] = a[43], a[6] = a[40], a[9] = a[37], a[43] = a[48], a[40] = a[51], a[37] = a[54], a[48] = a[21], a[51] = a[24], a[54] = a[27], a[21] = s[1], a[24] = s[2], a[27] = s[3], s[1] = a[10], s[2] = a[11], a[10] = a[16], a[11] = a[13], a[16] = a[18], a[13] = a[17], a[18] = a[12], a[17] = a[15], a[12] = s[1], a[15] = s[2], s[1] = a[28], s[2] = a[29], a[28] = a[30], a[29] = a[33], a[30] = a[36], a[33] = a[35], a[36] = a[34], a[35] = a[31], a[34] = s[1], a[31] = s[2]
}

function rot() {
    s[1] = a[25], s[2] = a[26], s[3] = a[27], a[25] = a[16], a[26] = a[17], a[27] = a[18], a[16] = a[43], a[17] = a[44], a[18] = a[45], a[43] = a[34], a[44] = a[35], a[45] = a[36], a[34] = s[1], a[35] = s[2], a[36] = s[3], s[1] = a[46], s[2] = a[47], a[46] = a[52], a[47] = a[49], a[52] = a[54], a[49] = a[53], a[54] = a[48], a[53] = a[51], a[48] = s[1], a[51] = s[2]
}

function roti() {
    s[1] = a[25], s[2] = a[26], s[3] = a[27], a[25] = a[34], a[26] = a[35], a[27] = a[36], a[34] = a[43], a[35] = a[44], a[36] = a[45], a[43] = a[16], a[44] = a[17], a[45] = a[18], a[16] = s[1], a[17] = s[2], a[18] = s[3], s[1] = a[46], s[2] = a[47], a[46] = a[48], a[47] = a[51], a[48] = a[54], a[51] = a[53], a[54] = a[52], a[53] = a[49], a[52] = s[1], a[49] = s[2]
}

function fd() {
    s[1] = a[19], s[2] = a[20], s[3] = a[21], a[19] = a[28], a[20] = a[29], a[21] = a[30], a[28] = a[37], a[29] = a[38], a[30] = a[39], a[37] = a[10], a[38] = a[11], a[39] = a[12], a[10] = s[1], a[11] = s[2], a[12] = s[3], s[1] = a[22], s[2] = a[23], s[3] = a[24], a[22] = a[31], a[23] = a[32], a[24] = a[33], a[31] = a[40], a[32] = a[41], a[33] = a[42], a[40] = a[13], a[41] = a[14], a[42] = a[15], a[13] = s[1], a[14] = s[2], a[15] = s[3], s[1] = a[25], s[2] = a[26], s[3] = a[27], a[25] = a[34], a[26] = a[35], a[27] = a[36], a[34] = a[43], a[35] = a[44], a[36] = a[45], a[43] = a[16], a[44] = a[17], a[45] = a[18], a[16] = s[1], a[17] = s[2], a[18] = s[3], s[1] = a[1], s[2] = a[2], a[1] = a[7], a[2] = a[4], a[7] = a[9], a[4] = a[8], a[9] = a[3], a[8] = a[6], a[3] = s[1], a[6] = s[2], s[1] = a[46], s[2] = a[47], a[46] = a[48], a[47] = a[51], a[48] = a[54], a[51] = a[53], a[54] = a[52], a[53] = a[49], a[52] = s[1], a[49] = s[2]
}

function uu() {
    bor(), bor(), rot(), bor(), bor()
}

function ui() {
    bor(), bor(), roti(), bor(), bor()
}

function ff() {
    bor(), rot(), bor(), bor(), bor()
}

function fi() {
    bor(), roti(), bor(), bor(), bor()
}

function rr() {
    fd(), bor(), rot(), bor(), bor(), bor(), fd(), fd(), fd()
}

function ri() {
    fd(), bor(), roti(), bor(), bor(), bor(), fd(), fd(), fd()
}

function ll() {
    fd(), fd(), fd(), bor(), rot(), bor(), bor(), bor(), fd()
}

function li() {
    fd(), fd(), fd(), bor(), roti(), bor(), bor(), bor(), fd()
}

function dd() {
    rot()
}

function di() {
    roti()
}

function bb() {
    bor(), bor(), bor(), rot(), bor()
}

function bi() {
    bor(), bor(), bor(), roti(), bor()
}

function scramble() {
    for (var i = 0; 100 > i; i++) {
        rand = Math.floor(12 * Math.random());
        0 == rand && uu();
        1 == rand && ui();
        2 == rand && ff();
        3 == rand && fi();
        4 == rand && dd();
        5 == rand && di();
        6 == rand && bb();
        7 == rand && bi();
        8 == rand && rr();
        9 == rand && ri();
        10 == rand && ll();
        11 == rand && li();
    }
    kiir();
}

var cubex = -20;
var cubey = 340;
var cubez = 0;
var segs = "yo";

var a = new Array;
var s = new Array;

var speed = 80;

var layeru = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 19, 20, 21, 28, 29, 30, 37, 38, 39];
var layerl = [10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 4, 7, 19, 22, 25, 46, 49, 52, 39, 42, 45];
var layerf = [19, 20, 21, 22, 23, 24, 25, 26, 27, 7, 8, 9, 12, 15, 18, 46, 47, 48, 28, 31, 34];
var layerr = [28, 29, 30, 31, 32, 33, 34, 35, 36, 3, 6, 9, 21, 24, 27, 48, 51, 54, 37, 40, 43];
var layerb = [37, 38, 39, 40, 41, 42, 43, 44, 45, 30, 33, 36, 10, 13, 16, 1, 2, 3, 52, 53, 54];
var layerd = [46, 47, 48, 49, 50, 51, 52, 53, 54, 25, 26, 27, 16, 17, 18, 25, 26, 27, 34, 35, 36, 43, 44, 45];
var layeru2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 19, 20, 21, 28, 29, 30, 37, 38, 39, 13, 14, 15, 22, 23, 24, 31, 32, 33, 40, 41, 42];
var layerl2 = [10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 4, 7, 19, 22, 25, 46, 49, 52, 39, 42, 45, 2, 5, 8, 20, 23, 26, 47, 50, 53, 38, 41, 44];
var layerf2 = [19, 20, 21, 22, 23, 24, 25, 26, 27, 7, 8, 9, 12, 15, 18, 46, 47, 48, 28, 31, 34, 4, 5, 6, 11, 14, 17, 29, 32, 35, 49, 50, 51];
var layerr2 = [28, 29, 30, 31, 32, 33, 34, 35, 36, 3, 6, 9, 21, 24, 27, 48, 51, 54, 37, 40, 43, 2, 5, 8, 20, 23, 26, 47, 50, 53, 38, 41, 44];
var layerb2 = [37, 38, 39, 40, 41, 42, 43, 44, 45, 30, 33, 36, 10, 13, 16, 1, 2, 3, 52, 53, 54, 4, 5, 6, 11, 14, 17, 29, 32, 35, 49, 50, 51];
var layerd2 = [46, 47, 48, 49, 50, 51, 52, 53, 54, 25, 26, 27, 16, 17, 18, 25, 26, 27, 34, 35, 36, 43, 44, 45, 13, 14, 15, 22, 23, 24, 31, 32, 33, 40, 41, 42];
var layerm = [2, 5, 8, 20, 23, 26, 47, 50, 53, 38, 41, 44];
var layere = [13, 14, 15, 22, 23, 24, 31, 32, 33, 40, 41, 42];
var layers = [4, 5, 6, 11, 14, 17, 29, 32, 35, 49, 50, 51];

var wholecube = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54];

var counter = 0;

$(document).ready(function() {

    initnotscrambled();

    $(".rotateU"      ).mousedown(function(){ turn("U")  });
    $(".rotateUi"     ).mousedown(function(){ turn("u")  });
    $(".rotateR"      ).mousedown(function(){ turn("R")  });
    $(".rotateRi"     ).mousedown(function(){ turn("r")  });
    $(".rotateD"      ).mousedown(function(){ turn("D")  });
    $(".rotateDi"     ).mousedown(function(){ turn("d")  });
    $(".rotateF"      ).mousedown(function(){ turn("F")  });
    $(".rotateFi"     ).mousedown(function(){ turn("f")  });
    $(".rotateB"      ).mousedown(function(){ turn("B")  });
    $(".rotateBi"     ).mousedown(function(){ turn("b")  });
    $(".rotateL"      ).mousedown(function(){ turn("L")  });
    $(".rotateLi"     ).mousedown(function(){ turn("l")  });
    $(".rotateU2"     ).mousedown(function(){ turn("U2") });
    $(".rotateU2i"    ).mousedown(function(){ turn("u2") });
    $(".rotateR2"     ).mousedown(function(){ turn("R2") });
    $(".rotateR2i"    ).mousedown(function(){ turn("r2") });
    $(".rotateD2"     ).mousedown(function(){ turn("D2") });
    $(".rotateD2i"    ).mousedown(function(){ turn("d2") });
    $(".rotateF2"     ).mousedown(function(){ turn("F2") });
    $(".rotateF2i"    ).mousedown(function(){ turn("f2") });
    $(".rotateB2"     ).mousedown(function(){ turn("B2") });
    $(".rotateB2i"    ).mousedown(function(){ turn("b2") });
    $(".rotateL2"     ).mousedown(function(){ turn("L2") });
    $(".rotateL2i"    ).mousedown(function(){ turn("l2") });
    $(".rotateM"      ).mousedown(function(){ turn("M")  });
    $(".rotateMi"     ).mousedown(function(){ turn("m")  });
    $(".rotateE"      ).mousedown(function(){ turn("E")  });
    $(".rotateEi"     ).mousedown(function(){ turn("e")  });
    $(".rotateS"      ).mousedown(function(){ turn("S")  });
    $(".rotateSi"     ).mousedown(function(){ turn("s")  });
    $(".rotateX"      ).mousedown(function(){ turn("X")  });
    $(".rotateY"      ).mousedown(function(){ turn("Y")  });
    $(".rotateZ"      ).mousedown(function(){ turn("Z")  });
    $(".rotateXi"     ).mousedown(function(){ turn("x")  });
    $(".rotateYi"     ).mousedown(function(){ turn("y")  });
    $(".rotateZi"     ).mousedown(function(){ turn("z")  });

    $(".rotateKiir"   ).mousedown(function(){ kiir() });

    $(".rotateXview"  ).mousedown(function(){ cubex += 5, rotCube() });
    $(".rotateYview"  ).mousedown(function(){ cubey += 5, rotCube() });
    $(".rotateZview"  ).mousedown(function(){ cubez += 5, rotCube() });
    $(".rotateXview"  ).mouseup(function(){ cubex += 5, rotCube() });
    $(".rotateYview"  ).mouseup(function(){ cubey += 5, rotCube() });
    $(".rotateZview"  ).mouseup(function(){ cubez += 5, rotCube() });
    $(".rotateXiview" ).mousedown(function(){ cubex -= 5, rotCube() });
    $(".rotateYiview" ).mousedown(function(){ cubey -= 5, rotCube() });
    $(".rotateZiview" ).mousedown(function(){ cubez -= 5, rotCube() });
    $(".rotateXiview" ).mouseup(function(){ cubex -= 5, rotCube() });
    $(".rotateYiview" ).mouseup(function(){ cubey -= 5, rotCube() });
    $(".rotateZiview" ).mouseup(function(){ cubez -= 5, rotCube() });

});
