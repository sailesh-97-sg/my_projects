chrome.runtime.onMessage.addListener(function (request, sender, sendResponse) {
    console.log("here");
    if (request.type === "reload") {
        console.log("reached");
        chrome.tabs.reload({ bypassCache: true });
    }
});