'use strict';

var env = {};

// Import variables if present (from env.js)
if(window){
    Object.assign(env, window.__env);
}

// Define AngularJS application
var ngModule = angular.module('vraUiApp', [
    'ngResource',
    'ngRoute',
    'ui.bootstrap',
    'ngAnimate',
    'ngTouch',
    'core',
    'home',
    'dashboard'
]);

// Register environment in AngularJS as constant
ngModule.constant('__env', env);
