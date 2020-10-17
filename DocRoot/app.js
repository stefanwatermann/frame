let apiUri = "/api";

$(document).ready(function () {
    GetHostInfo();
});

function doScreen(off) {
    console.debug("doScreen()");

    let p = "on";
    if (off) {
        p = "off";
    }

    $.get(apiUri + "/?screen" + p, function (data) {
        console.debug(data);
    });
}

function doShutdown(reboot) {
    console.debug("doShutdown()");

    let p = "shutdown";
    if (reboot) {
        p = "reboot";
    }

    $.get(apiUri + "/?" + p, function (data) {
        console.debug(data);
    });
}

function doNext() {
    console.debug("doNext()");

    $.get(apiUri + "/?next", function (data) {
        console.debug(data);
    });
}

function doDeleteCurrent() {
    console.debug("doDeleteCurrent()");

    if (confirm("Aktuelles Foto löschen?") === true) {
        $.get(apiUri + "/?deletecurrent", function (data) {
            console.debug(data);
            doReload();
        });
    }
}

function doUpload() {
    console.debug("doUpload()");

    $("#form-upload").submit();
}

function doReload() {
    console.debug("doReload()");

    $.get(apiUri + "/?reload", function (data) {
        console.debug(data);
    });
}

function doConfig() {
    console.debug("doConfig()");

    $.get(apiUri + "/?config", function (data) {
        console.debug(data);
    });
}

function GetHostInfo() {
    console.debug("GetHostInfo()");

    $.get(apiUri + "/?info", function (data) {
        $("#footer-info").text(data);
    });
}
