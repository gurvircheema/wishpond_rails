document.addEventListener("DOMContentLoaded", function() {
  var runningTimeNode = document.getElementById("currentTimer");
  var currentImageNode = document.getElementById("currentImage");
  var storePlayButton = document.getElementById("storeImage");
  var token = document.head.querySelector("[name=csrf-token]").content;

  var oneSecondInterval;
  if (currentImageNode !== null && currentImageNode !== undefined) {
    var dataTableNode = document.getElementById("timerTable");
    var urlArray = Object.values(
      JSON.parse(dataTableNode.getAttribute("data-images"))
    );
    var urlArrayLength = urlArray.length;
    var currentUrlIndex = 0;
  }

  // decreaseTimer function changes the timer tick and next image
  function decreaseTimer() {
    var tick = parseInt(runningTimeNode.innerHTML, 10);
    var nextTick = tick === 1 ? 10 : tick - 1;
    runningTimeNode.innerHTML = nextTick;
    if (currentImageNode !== null && currentImageNode !== undefined) {
      currentUrlIndex =
        currentUrlIndex === urlArrayLength - 1 ? 0 : currentUrlIndex + 1;
      currentImageNode.src = urlArray[currentUrlIndex];
    }
  }

  // One second interval for timer and image
  if (runningTimeNode !== null && runningTimeNode !== undefined) {
    oneSecondInterval = setInterval(decreaseTimer, 1000);
  }

  // storePlayButton element store current timer and image, if we have images to display
  storePlayButton.onclick = function() {
    if (urlArrayLength > 0) {
      timer = runningTimeNode.innerHTML;
      url = currentImageNode.src;
      ajax_post_play(timer, url);
    } else {
      storePlayButton.parentElement.innerHTML =
        "<p class='alert alert-danger'>There are no images</p>";
    }
  };

  // Ajax request to save play
  function ajax_post_play(timer, url) {
    xhr = new XMLHttpRequest();
    xhr.open("POST", "/plays");
    xhr.setRequestHeader("X-CSRF-Token", token);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(JSON.stringify({ timer: timer, url: url }));
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
          var tr = document.createElement("tr");
          var td1 = document.createElement("td");
          td1.innerHTML = timer;
          var td2 = document.createElement("td");
          var img = document.createElement("img");
          img.height = "200";
          img.alt = url.split("/").pop();
          img.src = url;
          td2.appendChild(img);
          tr.appendChild(td1);
          tr.appendChild(td2);
          document.getElementById("storedPlays").appendChild(tr);
        } else {
          console.error("Error: ", xhr.status, xhr.statusText);
        }
      }
    };
  }
});
