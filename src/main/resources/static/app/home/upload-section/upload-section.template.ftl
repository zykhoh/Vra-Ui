<div class="container padding-32">
    <h2>Upload Video Here</h2>
    <br/>
    <div uib-alert ng-if="gotMessage" ng-class="'alert-' + (message.type)" close="closeAlert()">{{message.msg}}</div>
    <form class="form-group" name="addVideoForm" id="addVideoForm" ng-submit="addVideo()">
        <div class="row">
            <div class="col-md-4">
                <input class="col-md-2 form-control" type="file" name="videoFile" required/>
            </div>
            <div class="col-md-2">
                <input class="col-md-2 form-control" type="submit" value="submit"/>
            </div>
        </div>
    </form>
</div>