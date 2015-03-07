window.onload = function(){
  
  document.getElementById("slide").style.visibility = "hidden";
  
  var start_slides = document.getElementById("start");
  start_slides.addEventListener("click", begin);
  function begin() {
    var req = new XMLHttpRequest;
    req.addEventListener("load", slide_display(this.response));
    req.open("get","http://localhost:4567/start_slideshow");
    req.send();
  }
  
  function slide_display(r) {
    document.getElementById("start").style.visibility = "hidden";
    var info = JSON.parse(r);
    var div_c = document.getElementById("slide");
    div_c.style.visibility = "visible";
    var children = div_c.childNodes;
    children[1].textContent = info["title"];
    children[2].textContent = info["body"];
    // children[3].setAttribute("value", info["next_s"]);
    // children[4].setAttribute("value", info["prev_s"]);
    
    
    // var next_slide = document.getElementById("next");
    // nsv = next_slide.getAttribute("value");
    // console.log(nsv);
    // if (nsv) {
    //   next_slide.addEventListener("click",change_slide(nsv));
    // }
  
    // var prev_slide = document.getElementById("prev");
    // psv = prev_slide.getAttribute("value");
    // console.log(psv);
    // if (psv) {
    //   prev_slide.addEventListener("click",change_slide(psv));
    // }
    
  }
  

  
  // function change_slide(v) {
  //   var req = new XMLHttpRequest;
  //   req.addEventListener("load", slide_display(this.response));
  //   req.open("get","http://localhost:4567/get_slide/"+v);
  //   req.send();
  // }
  
}
  