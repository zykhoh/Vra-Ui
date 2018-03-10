<!DOCTYPE html>

<html lang="en" ng-app="vraUiApp">

    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>VRA</title>

        <#-- Static Required Files -->

        <link rel="stylesheet" href="webjars/bootstrap/3.3.7-1/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="webjars/font-awesome/5.0.2/web-fonts-with-css/css/fontawesome.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway"/>
        <link rel="stylesheet" href="webjars/video-js/5.10.7/video-js.min.css"/>
        <script src="webjars/jquery/1.11.1/jquery.min.js"></script>
        <script src="webjars/bootstrap/3.3.7-1/js/bootstrap.min.js"></script>
        <script src="webjars/video-js/5.10.7/video.min.js"></script>
        <script src="/js/dash.all.min.js"></script>
        <script src="/js/videojs-dash.min.js"></script>

        <script src="webjars/angularjs/1.6.6/angular.min.js"></script>
        <script src="webjars/angularjs/1.6.6/angular-route.min.js"></script>
        <script src="webjars/angularjs/1.6.6/angular-resource.js"></script>
        <script src="webjars/angular-ui-bootstrap/2.2.0/ui-bootstrap-tpls.min.js"></script>
        <script src="webjars/angularjs/1.6.6/angular-animate.min.js"></script>
        <script src="webjars/angularjs/1.6.6/angular-touch.min.js"></script>

        <link rel="stylesheet" href="/css/app.css"/>


        <#-- AngularJs Files -->

        <script src="/app/env.js"></script>
        <script src="/app/app.module.js"></script>
        <script src="/app/app.config.js"></script>

        <#-- Core-Data -->

        <script src="/app/core/core.module.js"></script>
        <script src="/app/core/video/video.module.js"></script>
        <script src="/app/core/video/video.service.js"></script>
        <script src="/app/core/image/image.module.js"></script>
        <script src="/app/core/image/image.service.js"></script>

        <#--  Home-Page  -->

        <script src="/app/home/home.module.js"></script>
        <script src="/app/home/navbar/navbar.module.js"></script>
        <script src="/app/home/navbar/navbar.component.js"></script>
        <script src="/app/home/carousel-slideshow/carousel-slideshow.module.js"></script>
        <script src="/app/home/carousel-slideshow/carousel-slideshow.component.js"></script>
        <script src="/app/home/upload-section/upload-section.module.js"></script>
        <script src="/app/home/upload-section/upload-section.component.js"></script>
        <script src="/app/home/home-footer/home-footer.module.js"></script>
        <script src="/app/home/home-footer/home-footer.component.js"></script>

        <#--  Dashboard-Page  -->

        <script src="/app/dashboard/dashboard.module.js"></script>
        <script src="/app/dashboard/dashboard.component.js"></script>
        <script src="/app/dashboard/dashboard.controller.js"></script>
        <script src="/app/dashboard/header-title/header-title.module.js"></script>
        <script src="/app/dashboard/header-title/header-title.component.js"></script>
        <script src="/app/dashboard/video-player/video-player.module.js"></script>
        <script src="/app/dashboard/video-player/video-player.controller.js"></script>
        <script src="/app/dashboard/video-player/video-player.component.js"></script>
        <script src="/app/dashboard/search-section/search-section.module.js"></script>
        <script src="/app/dashboard/search-section/search-section.component.js"></script>
        <script src="/app/dashboard/search-result/search-result.module.js"></script>
        <script src="/app/dashboard/search-result/search-result.component.js"></script>
        <script src="/app/dashboard/dashboard-footer/dashboard-footer.module.js"></script>
        <script src="/app/dashboard/dashboard-footer/dashboard-footer.component.js"></script>


    </head>

    <body>

        <div ng-view></div>

    </body>

</html>