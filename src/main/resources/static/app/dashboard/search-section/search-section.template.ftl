<div class="container col-md-4">
    <div class="shadow">
        <uib-accordion class="panel boarderless">
            <div class="panel-heading text-center font-size-24">
                <b>Searcher</b>
            </div>
            <div uib-accordion-group class="panel-body shadow-bottom"heading="By Image Url" is-open="status.isFirstOpen" is-disabled="status.isFirstDisabled">
                <form>
                    <input class="form-control" type="text"/>
                </form>
            </div>
            <div uib-accordion-group class="panel-body shadow-bottom"heading="By Uploading Image" is-open="status.isSecondOpen" is-disabled="status.isSecondDisabled">
                <form>
                    <input class="form-control" type="file"/>
                </form>
            </div>
            <div uib-accordion-group class="panel-body shadow-bottom"heading="By Word" is-open="status.isThirdOpen" is-disabled="status.isThirdDisabled">
                <form class="form-group" name="wordSearch" id="wordSearch" ng-submit="$ctrl.searchCat()">
                    <input class="form-control" ng-model="$ctrl.searchTerm" type="text"/>
                </form>
            </div>
        </uib-accordion>
    </div>
</div>