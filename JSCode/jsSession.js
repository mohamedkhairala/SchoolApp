function UpdateSession(sender) {
    debugger;
    let o = {};
    if (sender.id.indexOf("txtIssueDate") !== -1) {
        // Do something for txtIssueDate
        o.key = "txtIssueDate"
        o.value = document.getElementById(sender.id).value;
    } else if (sender.id.indexOf("txtPeriod") !== -1) {
        // Do something for txtPeriod
    } else if (sender.id.indexOf("txtRemarks") !== -1) {
        // Do something for txtRemarks
    } else if (sender.id.indexOf("ddlStatus") !== -1) {
        // Do something for ddlStatus
    } else if (sender.id.indexOf("txtStatusRemarks") !== -1) {
        // Do something for txtStatusRemarks
    }
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/UpdateSession",
        data: JSON.stringify(o),
        dataType: "json",
        async: false,
        success: function (res) {
            debugger;
        },
        error: function (response) {
            alert(response.responseText);
        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
    //WebService.UpdateSession(o, function (res) {
    //    debugger;
    //})
}