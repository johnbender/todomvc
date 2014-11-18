var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
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

  var remaining;

  res.render('index', {
    todos: data.todos,

    // todo base on values
    completed: 1,
    remaining: remaining = 2,
    remainingPlural: remaining > 1,
    someCompleted: true
  });
});

module.exports = router;
