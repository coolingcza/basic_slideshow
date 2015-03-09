window.onload = function(){
  
  document.getElementById("slide").style.visibility = "hidden";
  
  var start_slides = document.getElementById("start");
  start_slides.addEventListener("click", begin_slides);
  function begin_slides() {
    var req = new XMLHttpRequest;
    req.addEventListener("load", slide_display);
    req.open("get","http://localhost:4567/start_slideshow");
    req.send();
  }
  
  function slide_display() {
    document.getElementById("start").style.visibility = "hidden";
    var info = JSON.parse(this.response);
    console.log(info);
    var div_c = document.getElementById("slide");
    div_c.style.visibility = "visible";
    var children = div_c.childNodes;
    children[1].textContent = info["title"];
    children[2].textContent = info["body"];
    if (info["prev_s"]) {
      prev_button = children[5];
      prev_button.style.visibility = "visible";
      prev_button.addEventListener("click", function() {
        change_slide(info["prev_s"])
      });
    } else {
      children[5].style.visibility = "hidden";
    }
    if (info["next_s"]) {
      children[7].style.visibility = "visible";
      children[7].addEventListener("click", function() {
        change_slide(info["next_s"])
      });
    } else {
      children[7].style.visibility = "hidden";
    }
    
    
    // var next_slide = document.getElementById("next");
    // console.log(next_slide);
    // if (next_slide.getAttribute("value")) {
    //   next_slide.addEventListener("click",change_slide(next_slide.getAttribute("value")));
    // }
  
    // var prev_slide = document.getElementById("prev");
    // console.log(prev_slide);
    // if (prev_slide.getAttribute("value")) {
    //   prev_slide.addEventListener("click",change_slide(prev_slide.getAttribute("value")));
    // }

    
  }
  

  
  function change_slide(v) {
    var req = new XMLHttpRequest;
    req.addEventListener("load", slide_display);
    req.open("get","http://localhost:4567/get_slide/"+v);
    req.send();
  }
  
}
  