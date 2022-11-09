var debug = false;
var command = "";
var errorLog = [];

document.onkeydown = function() {
    if (event.keyCode == 13) {
        if (command == "68859079781650979899100") {
            debug = true;
            $('#btnDebugViewVar').show();
            log('debug mode start!')
        }
        command = "";
    } else {
        command += event.keyCode;
        if (command.length > '68859079781650979899100'.length) {
            command = "";
        }
    }
};

var showLog = function() {
    if (debug) {
        debugLog('# [String] View var ==================================== #');
        debugLog('#   [-] commonCode');
        debugLog(commonCode);
        debugLog('#   [-] commonTableInfoDef');
        debugLog(commonTableInfoDef);
        debugLog('#   [-] layerInfoDef');
        debugLog(layerInfoDef);
        debugLog('# [End]    View var ==================================== #');
        debugLog('');
        debugLog('# [String] Log history ================================= #');
        $.each(errorLog, function( idx, item ) {
            debugLog('# [' + item.seq + '] ' + logTime(item.millisSinceEpoch) + ' ' + item.message);
        });
        debugLog('# [End]    Log history ================================= #');
    } else {
        return;
    }
}

var log = function( message ) {
    if (debug == true) {
        if (typeof window.console != 'undefined' && typeof window.console.log != 'undefined') {
            console.log(message);
        }

        errorLog.push({
            "seq" : (errorLog.length + 1),
            "millisSinceEpoch" : $.now(),
            "message" : message
        });
    }
};

var debugLog = function( message ) {
    if (debug == true) {
        if (typeof window.console != 'undefined' && typeof window.console.log != 'undefined') {
            console.log(message);
        }
    }
};

var logTime = function( millisSinceEpoch ) {
    var secondsSinceEpoch = (millisSinceEpoch / 1000) | 0;
    var secondsInDay = ((secondsSinceEpoch % 86400) + 86400) % 86400;
    var seconds = secondsInDay % 60;
    var minutes = ((secondsInDay / 60) | 0) % 60;
    var hours = (secondsInDay / 3600) | 0;
    return hours + (minutes < 10 ? ":0" : ":") + minutes + (seconds < 10 ? ":0" : ":") + seconds;
};