'use strict';

angular.
module('home.uploadSection').
component('uploadSection', {
    templateUrl : '/app/home/upload-section/upload-section.template.ftl',
    controller : ['Video', '$scope',
        function uploadVideoController(Video, $scope){

            $scope.gotMessage = false;
            $scope.message = {};
            $scope.newVideo = {};

            $scope.addVideo = function(){
                var form = document.getElementById('addVideoForm');
                var formData = new FormData(form);

                Video.add(formData, function(res) {
                    console.log('success');
                    $scope.gotMessage = true;
                    $scope.message.msg = 'Video uploaded and successfully added';
                    $scope.message.type = 'success';
                }, function(error) {
                    console.log('error');
                    $scope.gotMessage = true;
                    if (error.status == 404){
                        console.log('404');
                        $scope.message.msg = 'Ops!!! Server Not Found';
                        $scope.message.type = 'danger';
                    }
                    else if (error.status == 500){
                        console.log('500');
                        $scope.message.msg = 'Something wrong!!! Internal Server Error When uploading';
                        $scope.message.type = 'danger';
                    }
                    else{
                        console.log(error);
                        $scope.message.msg = 'UNKNOWN ERROR';
                        $scope.message.type = 'danger';
                    }
                });

            };

            $scope.closeAlert = function() {
                $scope.gotMessage = false;
            };

        }
    ]
});