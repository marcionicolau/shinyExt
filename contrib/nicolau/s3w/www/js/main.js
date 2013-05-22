if(window.FileReader) {
  addEventHandler(window, 'load', function() {
    var status = document.getElementById('status');
    var drop   = document.getElementById('drop');
    var list   = document.getElementById('list');

    function cancel(e) {
      if (e.preventDefault) { e.preventDefault(); }
      return false;
    };

    // Tells the browser that we *can* drop on this target
    addEventHandler(drop, 'dragover', cancel);
    addEventHandler(drop, 'dragenter', cancel);

    addEventHandler(drop, 'drop', function (e) {
      e = e || window.event; // get window.event if e argument missing (in IE)
      if (e.preventDefault) { e.preventDefault(); } // stops the browser from redirecting off to the image.
      var dt    = e.dataTransfer;
      var files = dt.files;

      for (var i=0; i<files.length; i++) {
        var file = files[i];
        var reader = new FileReader();
        //attach event handlers here...
      addEventHandler(reader, 'loadend', function(e, file) {
      	  var bin           = this.result;
          var newFile       = document.createElement('div');
      	  newFile.innerHTML = 'Loaded : '+file.name+' size '+file.size+' B';
      	  list.appendChild(newFile);
      	  var fileNumber = list.getElementsByTagName('div').length;
      	  status.innerHTML = fileNumber < files.length ? 'Loaded 100% of file '+fileNumber+' of '+files.length+'...'
        	: 'Done loading. processed '+fileNumber+' files.';

      	  var img = document.createElement("img");
      	  img.file = file;
      	  img.src = bin;
      	  list.appendChild(img);
    	}.bindToEventHandler(file));

        reader.readAsDataURL(file);
      }
      return false;
    });

  });
} else {
  document.getElementById('status').innerHTML = 'Your browser does not support the HTML5 FileReader.';
};

function addEventHandler(obj, evt, handler) {
  if(obj.addEventListener) {
    // W3C method
    obj.addEventListener(evt, handler, false);
  } else if(obj.attachEvent) {
    // IE method.
    obj.attachEvent('on'+evt, handler);
  } else {
    // Old school method.
    obj['on'+evt] = handler;
  }
};

Function.prototype.bindToEventHandler = function bindToEventHandler() {
  var handler = this;
  var boundParameters = Array.prototype.slice.call(arguments);
  //create closure
  return function(e) {
    e = e || window.event; // get window.event if e argument missing (in IE)
    boundParameters.unshift(e);
    handler.apply(this, boundParameters);
  }
};

function allowDrop(ev) {
  ev.preventDefault();
};

function drag(ev) {
  ev.dataTransfer.setData("Text",ev.target.id);
};

function drop(ev) {
  ev.preventDefault();
  var data=ev.dataTransfer.getData("Text");
  ev.target.appendChild(document.getElementById(data));
};

$(function() {
  $(".item").draggable({
    revert: true
  });

  $("#trash").droppable({
    tolerance: 'touch',
    over: function() {
      $(this).removeClass('out').addClass('over');
    },
    out: function() {
      $(this).removeClass('over').addClass('out');
    },
    drop: function() {
      var answer = confirm('Permantly delete this item?');
      $(this).removeClass('over').addClass('out');
    }
  });

  $("li > a#showDev").click(function() {
    $(this).find("i").toggleClass("icon-eye-close").toggleClass("icon-eye-open");
    $("div#dev").toggleClass("hide");
  });

  $("ul.nav > li > a").hover(function() {
    $(this).find("i").toggleClass("icon-large");
  });

});

/*
 *  Upload files to the server using HTML 5 Drag and drop from the folders on  your     local computer
 */

 function uploader(place, status, target, show) {

    // Upload image files
    upload = function(file) {
        // Firefox 3.6, Chrome 6, WebKit
        if(window.FileReader) { 
            // Once the process of reading file
            this.loadEnd = function() {
                bin = reader.result;                
                xhr = new XMLHttpRequest();
                xhr.open('POST', target+'?up=true', false);
                var body = bin;
                xhr.setRequestHeader('content-type', 'multipart/form-data;');
                xhr.setRequestHeader("file-name", file.name );
                xhr.setRequestHeader("mime-type", file.type );

                // Firefox 3.6 provides a feature sendAsBinary ()
                if(xhr.sendAsBinary != null) { 
                    xhr.sendAsBinary(body); 
                // Chrome 7 sends data but you must use the base64_decode on the PHP side
                } else { 
                    xhr.open('POST', target+'?up=true&base64=true', true);
                    xhr.setRequestHeader('UP-FILENAME', file.name);
                    xhr.setRequestHeader('UP-SIZE', file.size);
                    xhr.setRequestHeader('UP-TYPE', file.type);
                    xhr.send(window.btoa(bin));
                }
                if (show) {
                    var newFile  = document.createElement('div');
                    newFile.innerHTML = 'Loaded : '+file.name+' size '+file.size+' B';
                    document.getElementById(show).appendChild(newFile);             
                }
                if (status) {
                    document.getElementById(status).innerHTML = 'Loaded : 100%<br/>Next file ...';
                }
            };

            // Loading errors
            this.loadError = function(event) {
                switch(event.target.error.code) {
                    case event.target.error.NOT_FOUND_ERR:
                        document.getElementById(status).innerHTML = 'File not found!';
                        break;
                    case event.target.error.NOT_READABLE_ERR:
                        document.getElementById(status).innerHTML = 'File not readable!';
                        break;
                    case event.target.error.ABORT_ERR:
                        break; 
                    default:
                        document.getElementById(status).innerHTML = 'Read error.';
                }   
            };

            // Reading Progress
            this.loadProgress = function(event) {
                if (event.lengthComputable) {
                    var percentage = Math.round((event.loaded * 100) / event.total);
                    document.getElementById(status).innerHTML = 'Loaded : '+percentage+'%';
                }               
            };

            // Preview images
            this.previewNow = function(event) {     
                bin = preview.result;
                var img = document.createElement("img"); 
                img.className = 'addedIMG';
                img.file = file;   
                img.src = bin;
                document.getElementById(show).appendChild(img);
            };

            var reader = new FileReader();
            // Firefox 3.6, WebKit
            if(reader.addEventListener) { 
                reader.addEventListener('loadend', this.loadEnd, false);
                if (status != null) {
                    reader.addEventListener('error', this.loadError, false);
                    reader.addEventListener('progress', this.loadProgress, false);
                }
            // Chrome 7
            } else { 
                reader.onloadend = this.loadEnd;
                if (status != null) {
                    reader.onerror = this.loadError;
                    reader.onprogress = this.loadProgress;
                }
            }

            var preview = new FileReader();
            
            // Firefox 3.6, WebKit
            if(preview.addEventListener) { 
                preview.addEventListener('loadend', this.previewNow, false);
            // Chrome 7 
            } else { 
                preview.onloadend = this.previewNow;
            }

            // The function that starts reading the file as a binary string
            reader.readAsBinaryString(file);

            // Preview uploaded files
            if (show) {
                preview.readAsDataURL(file);
            }
        // Safari 5 does not support FileReader
        } else {
            xhr = new XMLHttpRequest();
            xhr.open('POST', target+'?up=true', true);
            xhr.setRequestHeader('UP-FILENAME', file.name);
            xhr.setRequestHeader('UP-SIZE', file.size);
            xhr.setRequestHeader('UP-TYPE', file.type);
            xhr.send(file); 

            if (status) {
                document.getElementById(status).innerHTML = 'Loaded : 100%';
            }
            if (show) {
                var newFile  = document.createElement('div');
                newFile.innerHTML = 'Loaded : '+file.name+' size '+file.size+' B';
                document.getElementById(show).appendChild(newFile);
            }   
        }               
    };

    // Function drop file
    this.drop = function(event) {
        event.preventDefault();
        var dt = event.dataTransfer;
        var files = dt.files;
        for (var i = 0; i<files.length; i++) {
            var file = files[i];
            upload(file);
        }
    };

    // The inclusion of the event listeners (DragOver and drop)

    this.uploadPlace =  document.getElementById(place);
    this.uploadPlace.addEventListener("dragover", function(event) {
        event.stopPropagation(); 
        event.preventDefault();
    }, true);
    this.uploadPlace.addEventListener("drop", this.drop, false); 
};
