'use strict';

angular
    .module('dashboard.videoPlayer')
    .controller('videoPlayerController', ['Video','Image', '$scope', function (Video, Image, $scope) {

        $scope.video = {};
        $scope.videoPlayer = videojs('currentVideo');
        $scope.videos = Video.query(
            function (successResponse) {
                console.log("res", successResponse);
                $scope.video.videoUrl = successResponse.content[0].videoUrl;
                $scope.video.title = successResponse.content[0].title;
                $scope.video.id = successResponse.content[0].id;
                $scope.video.date = successResponse.content[0].date;
                $scope.video.description = successResponse.content[0].description;
                $scope.videoPlayer.src([
                    {type: "video/mp4", src: $scope.video.videoUrl}
                ]);
            },
            function (errorResponse) {
                console.log(errorResponse);
            });

        $scope.$on('GoToVideo', function(events, video, videoUrl, curTime){
            $scope.video = video;
            console.log("Im here", videoUrl);
            $scope.videoPlayer.src([
                {type: "video/mp4", src: videoUrl}
            ]);
            $scope.videoPlayer.currentTime(curTime);
            $scope.videoPlayer.load();
            console.log("succeed");
        });

    }]);
