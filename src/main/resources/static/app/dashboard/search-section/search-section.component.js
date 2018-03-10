'use strict';

angular
.module('dashboard.searchSection')
.component('searchSection', {
    templateUrl: '/app/dashboard/search-section/search-section.template.ftl',
    bindings : {
        onSearchCat : '&'
    },
    controller : ['Image', '$scope', '$rootScope',
        function searchSectionController(Image, $scope, $rootScope) {

            this.searchCat = function () {
                $scope.images = Image.catSearch({cat:this.searchTerm});
                $rootScope.$broadcast('distributeImage', $scope.images);
            }

        }
    ]
});