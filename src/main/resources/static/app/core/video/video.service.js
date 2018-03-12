'use strict';

angular.
module('core.video').
factory('Video',
    function ($resource) {

        return $resource('', {}, {
            query   : {
                method:'GET',
                url: 'http://localhost:8080/api/videos?sort=id,desc'
            },
            get : {
                method:'GET',
                url: 'http://192.168.1.102:8080/video/:videoId'
            },
            add : {
                method: 'POST',
                url: 'http://localhost:8080/api/videos/add',
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            },
            remove : {},
            update : {}
        });

    }
);