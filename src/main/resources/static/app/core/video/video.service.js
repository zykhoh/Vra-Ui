'use strict';

angular.
module('core.video').
factory('Video',
    function ($resource) {

        return $resource('', {}, {
            query   : {
                method:'GET',
                url: 'http://192.168.1.102:8080/video/all',
                isArray: true
            },
            get : {
                method:'GET',
                url: 'http://192.168.1.102:8080/video/:videoId'
            },
            add : {
                method: 'POST',
                url: 'http://192.168.1.102:8080/video/add',
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            },
            remove : {},
            update : {}
        });

    }
);