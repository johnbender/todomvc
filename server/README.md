## TodoPerf

Our goal with this small test and the resulting data set was to find a lower bound on "Time to Usable" for a few "popular" MV* frameworks/libraries [1]. To that end we leveraged the most ubiquitous common application for which every framework seems to have an implementation, TodoMVC, if only to keep the focus on the data for each application.

### The Tests

The test itself rests on a few assumptions, primarily that the first page load matters for web applications [2]. Further we assume that the optimized version TodoMVC is simple enough that it represents a minimal application for these frameworks: no second loads, minimal (minimized) assets, and minimal logic. Intuitively we've done our best to be generous in our measurements without exploring a different application entirely.

We ran our tests using WebPageTest.org and the bulk testing spreadsheet [3]. We did five runs of each and discarded extreme outliers (2x results *higher* the mean). We tested a desktop and a mobile browser both at 3G, and the desktop again at Cable speeds all from the Dulles, VA data center. The time to first byte for each test suggests that the network overhead was acceptable.

### Results

Of all the numbers collected, the **Render Start** was of primary interest based on our understanding of why the first load is important. This is the earliest point at which a user could conceivably report the application "ready to use" and so it represents a generous approximation of "Time to Usable".

Notable within the results are the following:

* Both Ember and Angular hover around 4 seconds to **Render Start** on the shaped 3G connection.
* Both Ember and Angular are well above the 4 second mark for a Nexus 5 on the shaped 3G connection.
* Backbone does well, as both a client side only render and a server assist render (our alteration).

### Possible Issues

We did our best to think through possible issues with this testing approach including but not limited to the following questions:

"The sample set is small"

We'd definitely like to have outside confirmation of our data and this is why the test, the method, the code, and the spreadsheet are being made available along with our reasoning. In general though, the results were consistent enough across runs performed outside those reported in the spreadsheet to give us confidence in them as a good first approximation of the lower bounds we were looking for.

"TodoMVC is not built with load times in mind"

It is definitely the case that the TodoMVC examples were constructed as an educational resource and not optimized for render times. Our understanding is that the logic required for the Todo application is small enough to make the gains possible through optimization here very small.

"Poorly configured server"

Our configuration involves the following optimizations to each of the test pages:

1. Removing the commong TodoMVC "Learn" section from the JavaScript.
2. Concatenating and minifying all other JavaScript [4].
3. Moving the blocking CSS to the bottom of the `body` [4]. Note, this means that **Render Start** will often include unstyled markup as a further concession.
4. Everything served with compression [5].

Ultimately, the time to first byte numbers included in the data suggests that the server performed well enough to be representative of normal network and server conditions.

### Notes

1. Popularity here is defined as "Those frameworks we've heard the most noise about recently". If you want to add one, feel free to run the tests for your preferred framework/library.
2. Link to information on why first load matters
3. Link to bulk testing spreadsheet
4. e.g. https://github.com/johnbender/todomvc/blob/device-timing/examples/backbone/index.html#L50
5. https://github.com/johnbender/todomvc/blob/device-timing/server/app.js#L29
