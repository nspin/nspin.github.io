(function(window, document){
  document.addEventListener("DOMContentLoaded", function(event) {
    var supportPageOffset = window.pageXOffset !== undefined;
    var isCSS1Compat = ((document.compatMode || "") === "CSS1Compat");
    var nav = document.getElementById("navigation");
    window.addEventListener("scroll", function(e) {  
      var x = supportPageOffset
              ? window.pageXOffset
              : isCSS1Compat
                ? document.documentElement.scrollLeft
                : document.body.scrollLeft;
      nav.style.left = -x + "px";
    });
  });
})(window, document);