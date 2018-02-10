(function(window, document){
  document.addEventListener("DOMContentLoaded", function(event) {
    var supportPageOffset = window.pageXOffset !== undefined;
    var isCSS1Compat = ((document.compatMode || "") === "CSS1Compat");
    var navigation = document.getElementById("navigation");
    function getX() {
      return supportPageOffset ? window.pageXOffset : isCSS1Compat ? document.documentElement.scrollLeft : document.body.scrollLeft;
    }
    function getY() {
      return supportPageOffset ? window.pageYOffset : isCSS1Compat ? document.documentElement.scrollTop : document.body.scrollTop;
    }
    window.addEventListener("scroll", function(e) {  
      if (document.documentElement.clientWidth < 822) {
        navigation.style.top = -getY() + "px";
      } else {
        navigation.style.left = -getX() + "px";
      }
    });
  });
})(window, document);