var express = require('express');
var router = express.Router();
var fs = require( 'fs' );

// fake data to start
var data = {
  todos: [
    {
      title: "foo",
      completed: true
    },

    {
      title: "bar",
      completed: false
    },

    {
      title: "baz",
      completed: false
    }
  ]
};


var templates = [];

// get the templates for inclusion in the document
fs.readdirSync("views/client/").forEach(function( file ) {
  templates.push({
    name: file.toString().replace(/\.mustache/, ""),
    markup: fs.readFileSync("views/client/" + file)
  });
});


/* GET home page. */
router.get('/', function(req, res) {
  var remaining;

  res.render('index', {
    templates: templates,

    todos: data.todos,

    // TODO base on values
    completed: 1,
    remaining: remaining = 2,
    remainingPlural: remaining > 1,
    someCompleted: true
  });
});

module.exports = router;
