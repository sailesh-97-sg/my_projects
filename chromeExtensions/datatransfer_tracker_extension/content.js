

//This function is to check whether there is a value for isRefreshed stored, if not store a default value of false
//isRefreshed is used to check whether the page is refreshed.
//https://stackoverflow.com/questions/38261197/how-to-check-if-a-key-is-set-in-chrome-storage
let defaultRefreshValue = false;
chrome.storage.sync.get({ isRefreshed: defaultRefreshValue }, function (data) {
    // data.isRefreshed will be either the stored value, or defaultValue if nothing is set
    chrome.storage.sync.set({ isRefreshed: data.isRefreshed }, function () {
        // The value is now stored, so you don't have to do this again
    });
});

chrome.storage.local.get(['isRefreshed'], function (result) {
    if (result.isRefreshed == false) {
        // Get size of data transferred for visited website (For First Time Visitor)
        //Assume that there is no cached data currently. Need to find a way to clear cached data using command to incorporate into this function. 
        //*insert function to clear cache and refresh page*
        setTimeout(function getFirstVisitDataTransfer() {
            console.log("isRefreshed is currently false")
            var count = 0;
            var p = performance.getEntries();
            for (var i = 0; i < p.length; i++) {
                if ("transferSize" in p[i]) {
                    count = count + p[i].transferSize;
                }
            }
            chrome.storage.local.set({ firstVisitTransferSize: count * 10 ** (-9) }, function () {
                console.log("firstVisitTransferSize has been set to " + count * 10 ** (-9));
            })
            chrome.storage.local.set({ isRefreshed: true }, function () {
                console.log("Page will now refresh");
            })
            // Convert octets to GB
            return console.log('Amount of Data Transferred During First Visit: ' + count * 10 ** (-9) + ' GB');
        }, 5000)
        window.setTimeout(function () { location.reload() }, 7000);
    }
    else {
        setTimeout(function getReturningVisitDataTransfer() {
            console.log("The page has been refreshed, and isRefreshed is set to True")
            var count = 0;
            var p = performance.getEntries();
            for (var i = 0; i < p.length; i++) {
                if ("transferSize" in p[i]) {
                    count = count + p[i].transferSize;
                }
            }
            chrome.storage.local.set({ isRefreshed: false }, function () {
                console.log("isRefreshed has been set back to false");
            })
            chrome.storage.local.set({ returningVisitTransferSize: count }, function () {
                console.log("ReturningVisitTransferSize has been set to " + count * 10 ** (-9) + 'GB');
            })

            setTimeout(function () {
                chrome.storage.local.get(['firstVisitTransferSize'], function (result) {
                    console.log('Amount of Data Transferred During First Visit: ' + result.firstVisitTransferSize + 'GB')
                })
            }, 2000)

            setTimeout(function () {
                chrome.storage.local.get(['firstVisitTransferSize'], function (result) {
                    var energyPerVisit = result.firstVisitTransferSize * 0.81 * 0.75 + (count * 10 ** (-9)) * 0.81 * 0.25 * 0.02
                    console.log('Energy per Visit in kWh (E): ' + energyPerVisit + ' kWh');
                })
            }, 2100)
            // Convert octets to GB
            return setTimeout(function () { console.log('\nAmount of Data Transferred During Returning Visit: ' + count * 10 ** (-9) + ' GB') }, 2000);
        }, 5000)
    }

})

