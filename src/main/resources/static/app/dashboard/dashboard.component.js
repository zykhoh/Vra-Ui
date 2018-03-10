'use strict';

angular
    .module('dashboard')
    .component('dashboard', {
        templateUrl: '/app/dashboard/dashboard.template.ftl',
        controller : 'dashboardController'
    });