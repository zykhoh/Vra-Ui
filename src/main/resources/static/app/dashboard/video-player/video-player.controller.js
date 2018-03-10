'use strict';

angular
    .module('dashboard.videoPlayer')
    .controller('videoPlayerController', ['Video','Image', '$scope', function (Video, Image, $scope) {

        $scope.video = {};
        $scope.videoPlayer = videojs('currentVideo');
        $scope.videos = Video.query(
            function (successResponse) {
                $scope.video.videoUrl = successResponse[0].videoUrl;
                $scope.video.name = successResponse[0].name;
                console.log("video", $scope.video.videoUrl);
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
