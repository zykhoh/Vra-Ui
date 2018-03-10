'use strict';

angular.
module('vraUiApp').
config(['$locationProvider' ,'$routeProvider',
    function config($locationProvider, $routeProvider) {

        $locationProvider.hashPrefix('!');

        $routeProvider
            .when('/', {
                templateUrl: '/app/home/home.template.ftl'
            })
            .when('/dashboard', {
                template: '<dashboard></dashboard>'
            })
            .otherwise('/');
    }
]);