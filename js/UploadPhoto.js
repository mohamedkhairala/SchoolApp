function UploadIconStarted(sender, args) {
     var fileName = args.get_fileName();
    var img = sender.get_id() === "fuSignature" ? document.getElementById('imgSignatureLoader') : document.getElementById('imgIconLoader');
    img.style.display = 'block';
}
 
function UploadIconCompleted(sender, args) {
    var fileLength = args.get_length();
    var fileType = args.get_contentType();
    var url = args.get_fileName();
    var img = document.getElementById('imgIconLoader');
    // check file type
    if (url.split(".").pop().toLowerCase() != "jpg" && url.split(".").pop().toLowerCase() != "png" && url.split(".").pop().toLowerCase() != "jpeg" && url.split(".").pop().toLowerCase() != "gif") {
        alert("File Type Error");
        img.style.display = 'none';
        return;
    }
    // set paths to icon image and hidden field
    document.getElementById('imgIcon').src = '../Users_Photos/' + args.get_fileName();
    document.getElementById('HiddenIcon').value = '~/Users_Photos/' + args.get_fileName();
    img.style.display = 'none';
    switch (true) {
        case (fileLength > 1000000):
            fileLength = fileLength / 1000000 + 'MB';
            break;
        case (fileLength < 1000000):
            fileLength = fileLength / 1000000 + 'KB';
            break;
        default:
            fileLength = '1 MB';
            break;
    }
}
 
function UploadIconError() {
}
 

// start of upload functions for employee documents single upload
function UploadFileStarted(sender, args) {
    var fileName = args.get_fileName();
    var img = document.getElementById('imgFileLoader');
    img.style.display = 'block';
}

function UploadFileCompleted(sender, args) {
    var url = args.get_fileName();
    var ClientName = document.getElementById('lblSelectedFolder').value;
    var file_id = document.getElementById('hfDateNow').value;
    var img = document.getElementById('imgFileLoader');
    var file_type = url.split(".").pop().toLowerCase()
    if (file_type != "doc" && file_type != "docx" && file_type != "xls" && file_type != "xlsx" && file_type != "ppt" && file_type != "pptx" &&
        file_type != "pdf" && file_type != "txt" && file_type != "jpg" && file_type != "jpeg" && file_type != "png" && file_type != "gif") {
        alert("File Type Error");
        img.style.display = 'none';
        return;
    }
    url = file_id + "_" + url;
    if (file_type == "doc" || file_type == "docx") {
        document.getElementById('imgFile').src = "../images/word.png";
    } else if (file_type == "xls" || file_type == "xlsx") {
        document.getElementById('imgFile').src = "../images/icon-xlsx.png";
    } else if (file_type == "ppt" || file_type == "pptx") {
        document.getElementById('imgFile').src = "../images/powerpoint.png";
    } else if (file_type == "pdf") {
        document.getElementById('imgFile').src = "../images/pdf_icon.png";
    } else if (file_type == "txt") {
        document.getElementById('imgFile').src = "../images/icon-text.png";
    } else if (file_type == "jpg" || file_type == "jpeg" || file_type == "png" || file_type == "gif") {
        document.getElementById('imgFile').src = "../" + ClientName + "/" + url;
    }
    document.getElementById('HiddenFilePath').value = "../" + ClientName + "/" + url;
    document.getElementById('HiddenFileType').value = file_type;
    img.style.display = 'none';
}

function UploadFileError() {
}
// end of upload functions for employee documents single upload