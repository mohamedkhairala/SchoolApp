var PageURL = document.URL;
var lastIndex = PageURL.lastIndexOf("/");
var PageName = PageURL.substring(lastIndex + 1).split(".")[0];

if (PageName == "") {
    document.getElementById("Dashboard").className = document.getElementById("Dashboard").className+" menu-active";
}
else {
    var cntrlPage = document.getElementById(PageName);
    if (cntrlPage != null) {
        var cntrlClass = cntrlPage.className;
        var cntrlParentId = document.getElementById(PageName).lang;
        var cntrlParent = document.getElementById(cntrlParentId);
        if (cntrlParent != null) {
            var cntrlParentClosest = document.getElementById(cntrlParentId).closest('li');
            var cntrlParentClass = cntrlParent.className;
            var cntrlParentClosestClass = cntrlParentClosest.className;
            cntrlParent.className = cntrlParentClass + " sub-group-active";
            cntrlParentClosest.className = cntrlParentClosestClass + " active";
        }
        document.getElementById(PageName).className = cntrlClass + " menu-active";
    }
    
}
