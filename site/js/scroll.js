(function(window, document){

  document.addEventListener("DOMContentLoaded", function(event) {

    var getScroll =
      (window.pageXOffset !== undefined)
        ? { x: function() { return window.pageXOffset; },
            y: function() { return window.pageYOffset; }
          }
        : ((document.compatMode || "") === "CSS1Compat")
          ? { x: function() { return document.documentElement.scrollLeft; },
              y: function() { return document.documentElement.scrollTop; }
            }
          : { x: function() { return document.body.scrollLeft; },
              y: function() { return document.body.scrollTop; }
            }
      ;

    var media = window.matchMedia("(max-width: 821px)");
    var navigation = document.getElementById("navigation");

    function updateNavigation(e) {
      if (media.matches) {
        navigation.style.top = -getScroll.y() + "px";
      } else {
        navigation.style.left = -getScroll.x() + "px";
      }
    }

    window.addEventListener("scroll", updateNavigation);
    window.addEventListener("resize", updateNavigation);
    window.addEventListener("ontouchmove", updateNavigation);

    // bad
    setInterval(updateNavigation, 20);

  });

})(window, document);
