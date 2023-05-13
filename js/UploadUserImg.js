function UploadStarted(sender, args) {
    var fileName = args.get_fileName();
    var img = document.getElementById('imgIconLoader');
    img.style.display = 'block';
}

function UploadPhotoCompleted(sender, args) {
    var fileLength = args.get_length();
    var fileType = args.get_contentType();
    var url = args.get_fileName();
    var img = document.getElementById('imgIconLoader');
    if ( url.split(".").pop().toLowerCase() != "jpg" && url.split(".").pop().toLowerCase() != "png" && url.split(".").pop().toLowerCase() != "jpeg" ) {
        alert("File Type Error");
        img.style.display = 'none';

        return;
    }
   

    document.getElementById('imgIcon').src = 'Users_Photos/' + args.get_fileName();
    document.getElementById('HiddenIcon').value = '~/Users_Photos/' + args.get_fileName();
  
    img.style.display = 'none';
}

function UploadError() {

}