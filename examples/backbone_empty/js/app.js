/*global $ */
/*jshint unused:false */
var app = app || {};
var ENTER_KEY = 13;
var ESC_KEY = 27;

$(function () {
	'use strict';

	// render the initial template once
	// NOTE this is entirely to ensure that the "render start" times
	// in our performance tests represent a "usable" application
	$('body').append(_.template($('#app-template').html()));

	// kick things off by creating the `App`
	new app.AppView();
});
