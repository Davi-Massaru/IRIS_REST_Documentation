function setChevronState(id) {
    var list = document.getElementById(id);

    chevron = list.children[0].children[2].children[0].classList;

    if (chevron.contains("play-right-to-down")) {
        chevron.remove("play-right-to-down");
        chevron.add("play-down-to-right");

        return;
    }
        
    chevron.remove("play-down-to-right");
    chevron.add("play-right-to-down");
}
