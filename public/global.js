var next_s, prev_s;

window.onload = function(){
  
  document.getElementById("slide").style.visibility = "hidden";
  
  document.getElementById("prev_s").addEventListener("click",function() {
    change_slide(prev_s);
  });
  document.getElementById("next_s").addEventListener("click",function() {
    change_slide(next_s);
  });
  
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
    var div_c = document.getElementById("slide");
    div_c.style.visibility = "visible";
    var children = div_c.childNodes;
    children[5].textContent = info["title"];
    children[7].textContent = info["body"];
    if (info["prev_s"]) {
      children[1].style.visibility = "visible";
      prev_s = info["prev_s"];
    } else {
      children[1].style.visibility = "hidden";
    }
    if (info["next_s"]) {
      children[3].style.visibility = "visible";
      next_s = info["next_s"];
    } else {
      children[3].style.visibility = "hidden";
    }
    
  }
  
  function change_slide(v) {
    var req = new XMLHttpRequest;
    req.addEventListener("load", slide_display);
    req.open("get","http://localhost:4567/get_slide/"+v);
    req.send();
  }
  
}
  