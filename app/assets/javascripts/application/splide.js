var sliders = document.querySelectorAll('.splide'),
    i = 0;

if (sliders) {
    for (i = 0; i < sliders.length; i += 1) {
        new Splide(sliders[i], {
            pagination: false,
            perPage: 2,
            autoHeight: true
        }).mount();
    }
}
