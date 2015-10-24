function PlayScanSound() {
    var soundControl = document.getElementById("soundControl");
    try {
        soundControl.stop();
        soundControl.play();

    } catch (m) {
    }
}