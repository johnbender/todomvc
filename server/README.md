## TodoPerf

Our goal with this small test and the resulting data set was to find a lower bound on "time to usable" for a few popular MV* frameworks/libraries. To that end we leveraged the most ubiquitous common application for which every framework seems to have an implementation, TodoMVC, if only to minimize the number of variables under consideration.

### The Tests

The test itself rests on a few assumptions, primarily that the first page load matters for web applications. Further we assume that the optimized version of TodoMVC is simple enough that it represents a minimal application for these frameworks: no second loads, small (minimized) assets, and little logic. Intuitively, we've done our best to be generous with the test construction short of exploring a different application entirely.

We ran our tests using WebPageTest.org and the bulk testing spreadsheet [1]. We kept twenty runs of each and discarded extreme outliers (results 2x *higher* than the mean). We tested a desktop and a mobile browser both at 3G, and the desktop again at Cable speeds all from the Dulles, VA data center. The time to first byte for each test suggests that the network overhead was acceptable.

### Results

Of all the numbers collected, we were most interested in **Render Start**. This is the earliest point at which a user could conceivably report the application "ready to use" and so it represents a generous approximation of "time to usable".

Notable within the **Render Start** results are the following:

* Both Ember and Angular hover around 4 seconds on the shaped 3G connection.
* Both Ember and Angular are well above the 4 second mark for a Nexus 5 on the shaped 3G connection.
* Backbone does fairly well, as both a client side only render and a server assist render (our alteration).

### Possible Issues

We did our best to think through possible issues with this testing approach including but not limited to the following questions:

"The sample set is small"

We'd definitely like to have outside confirmation of our data and this is why the test, the method, the code, and the spreadsheet are being made available along with our reasoning. Otherwise the calculated confidence intervals suggest that the sample mean is a good indicator of how these pages would consistently perform under the network conditions found in the Dulles, VA data center.

"TodoMVC is not built with load times in mind"

The TodoMVC examples were constructed as an educational resource and not optimized for render times. Our understanding is that the logic required for the Todo application is small enough that the gains possible through optimization here are very small.

"Poorly configured server"

Our configuration involves the following optimizations to each of the test pages:

1. Removing the common TodoMVC "Learn" section from the JavaScript.
2. Concatenating and minifying all other JavaScript [2].
3. Inlining the CSS into the `head` of the document [3].
4. Serving assets with compression [4].

In addition we set up our test server in Digital Ocean's New York data center and ran the tests using the Dulles, VA WebPageTest servers. The time to first byte numbers included in the data suggests that the server performed well enough to represent normal network and server conditions where assets would be served by a CDN.

### Notes

1. https://github.com/andydavies/WPT-Bulk-Tester
2. e.g. https://github.com/johnbender/todomvc/blob/device-timing/examples/backbone/index.html#L53
3. e.g. https://github.com/johnbender/todomvc/blob/device-timing/examples/backbone/index.html#L7
4. https://github.com/johnbender/todomvc/blob/device-timing/server/app.js#L29
