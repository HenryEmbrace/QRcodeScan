var exec = require('cordova/exec');

exports.ScanMethod = function (arg0, success, error) {
    exec(success, error, 'QRcodeScan', 'ScanMethod', [arg0]);
};
