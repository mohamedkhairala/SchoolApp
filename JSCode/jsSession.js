function UpdateSession(sender) {
    debugger;
    let o = {};
     if (sender.id.indexOf("txtIssueDate") !== -1) {
        // Do something for txtIssueDate
        o.key = "IssueDate"
    } else if (sender.id.indexOf("txtPeriod") !== -1) {
        // Do something for txtPeriod
        o.key = "DefaultPeriodHour"
     } else if (sender.id.indexOf("txtRemarks") !== -1) {
        // Do something for txtRemarks
        o.key = "Remarks"
    } else if (sender.id.indexOf("ddlStatus") !== -1) {
        // Do something for ddlStatus
        o.key = "Status"
    } else if (sender.id.indexOf("txtStatusRemarks") !== -1) {
        // Do something for txtStatusRemarks
        o.key = "StatusRemarks"
    }
    o.id = $(sender).closest("tr").find("input[id*='txtSessionID']").val();
    o.value = document.getElementById(sender.id).value;

    WebService.UpdateSession(JSON.stringify(o), function (res) {
        debugger;
    })
}


function SelectGroup(groupId) {
    $("#divAdd").attr('style', 'display: none !important');
    if (groupId != "0") {
        $("#divAdd").attr('style', 'display: inline-flex !important');
        $("#lbAdd").attr('href', "Session.aspx?GroupId=" + groupId);

    }
}