(function() {
  'use strict';
  angular.module('app').controller('musiciansCtrl', function($scope) {
    $scope.messages = ['hello world!', 'goodbye', 'hello again'];
    $scope.alertMe = function(message) { alert(message); };
    $scope.addMessage = function(message) { $scope.messages.push(message); };
    window.$scope = $scope;
  });
})();