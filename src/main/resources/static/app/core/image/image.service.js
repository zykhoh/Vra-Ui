'use strict';

angular.
module('core.video').
factory('Image',
    function ($resource) {

        return $resource('', {}, {
            catSearch   : {
                method:'GET',
                url: 'http://192.168.1.102:8080/search/cat/:cat',
                isArray: true
            }
        });

    }
);