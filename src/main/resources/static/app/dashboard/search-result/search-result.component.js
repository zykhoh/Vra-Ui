'use strict';

angular
.module('dashboard.searchResult')
.component('searchResult', {
    templateUrl: '/app/dashboard/search-result/search-result.template.ftl',
    controller : ['$scope', '$rootScope', 'Video',
        function searchResultController($scope, $rootScope, Video){

            $scope.$on('distributeImage', function(events, args){
                $scope.images = args;
                console.log($scope.images);
            });

            this.GoToVideo = function (videoId, curTime) {
                console.log('GoToVideo Function');
                $scope.video = Video.get({videoId:videoId},
                    function (successResponse) {
                        $scope.video.videoUrl = successResponse.videoUrl;
                        $scope.video.name = successResponse.name;
                        $scope.video.curTime = curTime;
                        $rootScope.$broadcast('GoToVideo', $scope.video, $scope.video.videoUrl, $scope.video.curTime);
                    },
                    function (errorResponse) {
                        console.log(errorResponse);
                    });
            }

    }]
});