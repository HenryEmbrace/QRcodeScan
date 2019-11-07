# QRcodeScan
ionic plugin for iOS QRcodeScan

头部声明：
declare let cordova:any;

调用示例：
cordova.plugins.QRcodeScan.ScanMethod("测试调用",result=> {
      alert(result)
    } ,error=> {
      alert(error)
    });
