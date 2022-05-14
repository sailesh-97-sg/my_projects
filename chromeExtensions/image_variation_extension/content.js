console.log('Hello!')
let imgs = document.getElementsByTagName("img");



function handleRemoveElement(el) {
    imgs.forEach((e) => {
        const srcs = e.document.getAttribute("src");
        if (srcs === "" || "") {
            srcs.remove();
        }
    });
}


function changeColorVariation() {
    for (img of imgs) {
        console.log(img.src)
        img.style.filter = 'contrast(80%) grayscale(80%) opacity(90%) saturate(18%)';

    }
}
setInterval(handleRemoveElement, 500)
setInterval(changeColorVariation, 500)
