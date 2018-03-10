<div class="container gallery-container">
    <h1>Search Results</h1>

    <p class="page-description text-center">Search Results With Tags</p>

    <div class="tz-gallery">
        <div class="col-sm-6 col-md-4" ng-repeat="img in images">
            <div class="thumbnail shadow">
                <a class="lightbox" ng-click="$ctrl.GoToVideo(img.videoId, img.curTime)">
                    <img src="{{img.imgUrl}}" alt="Park">
                </a>
                <div class="caption">
                    <span class="badge" ng-repeat="cat in img.cat track by $index">{{cat}}</span>
                </div>
            </div>
        </div>
    </div>
</div>