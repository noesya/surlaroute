//= require leaflet/dist/leaflet.js

/* eslint-disable no-underscore-dangle */
/* global L */

delete L.Icon.Default.prototype._getIconUrl;

L.NumberedDivIcon = L.Icon.extend({
    options: {
        iconUrl: window.map ? window.map.iconUrl : '',
        number: '',
        shadowUrl: null,
        iconSize: new L.Point(25, 41),
        iconAnchor: new L.Point(13, 41),
        popupAnchor: new L.Point(0, -33),
        className: 'leaflet-div-icon'
    },

    createIcon: function () {
        'use strict';
        var div = document.createElement('div'),
            img = this._createImg(this.options['iconUrl']),
            numdiv = document.createElement('div');
        img.setAttribute('alt', '');
        img.setAttribute('height', '27');
        img.setAttribute('width', '27');
        numdiv.setAttribute('class', 'number');
        numdiv.innerHTML = this.options['number'] || '';
        div.appendChild(img);
        div.appendChild(numdiv);
        this._setIconStyles(div, 'icon');
        return div;
    },
    createShadow: function () {
        'use strict';
        return null;
    }
});

L.Icon.Default.mergeOptions({
    iconUrl: window.map ? window.map.iconUrl : '',
    iconSize: [27, 27],
    iconRetinaUrl: '',
    shadowUrl: ''
});

window.ecotheque = window.ecotheque || {};

window.ecotheque.maps = {
    init: function () {
        'use strict';
        var mapElements = document.querySelectorAll('.js-map'),
            i = 0;
        this.maps = [];
        for (i = 0; i < mapElements.length; i += 1) {
            this.display(mapElements[i]);
        }
    },

    reset: function () {
        'use strict';
        var i;
        for (i = 0; i < this.maps.length; i += 1) {
            this.maps[i].remove();
        }
        this.init();
    },

    display: function (mapElement) {
        'use strict';
        var lat = parseFloat(mapElement.dataset.latitude, 10),
            long = parseFloat(mapElement.dataset.longitude, 10),
            zoom = 15,
            markerIcon = null,
            copyright = 'données © <a href="//osm.org/copyright">OpenStreetMap</a>/ODbL - rendu ©CartoDB',
            // tile = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            tile = 'https://{s}.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}.png',
            mymap;

        mymap = L.map(mapElement, { scrollWheelZoom: false, tap: false }).setView([lat, long], zoom);

        this.maps.push(mymap);
        L.tileLayer(tile, {
            attribution: copyright,
            minZoom: 1,
            maxZoom: 18
        }).addTo(mymap);

        if (!mapElement.dataset.markers) {
            L.marker([lat, long]).addTo(mymap);
            markerIcon = document.querySelector('.leaflet-marker-icon');
            if (markerIcon) {
                markerIcon.setAttribute('height', '27');
                markerIcon.setAttribute('width', '27');
            }
        } else if (window.map) {
            this.geojsonLayer = L.geoJSON(window.map.markers, {
                onEachFeature: this.bindFeaturePopin.bind(this),
                pointToLayer: function (feature) {
                    return L.marker(feature.geometry.coordinates, {
                        title: feature.properties.name,
                        icon: new L.NumberedDivIcon({ number: feature.properties.number })
                    });
                }
            }).addTo(mymap);
            mymap.fitBounds(this.geojsonLayer.getBounds());
        }
    },

    bindFeaturePopin: function (feature, layer) {
        'use strict';
        if (feature.properties && feature.properties.popinContent) {
            layer.bindPopup(feature.properties.popinContent);
        }
    },

    invoke: function () {
        'use strict';
        return {
            init: this.init.bind(this),
            reset: this.reset.bind(this)
        };
    }
}.invoke();

document.addEventListener('DOMContentLoaded', function () {
    'use strict';
    window.ecotheque.maps.init();
});
