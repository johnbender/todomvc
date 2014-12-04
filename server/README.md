## TodoPerf

Our goal with this small test and the resulting data set was to find a lower bound on load times for a few "popular" MV* frameworks[1]. To that end we leveraged the most ubiquitous common application available for which every frameworks seems to have an implementation, TodoMVC.

### The Tests

Our testing method involved WebPageTest.org and the bulk testing spreadsheet[1] to run our tests. We did five runs of each and discarded extreme outliers (2x or higher results relative to the mean). We tested a desktop and a mobile browser both at 3G, and the desktop again at Cable speeds all from the Dulles, VA data center. The time to first byte for each test suggests that the network latency was acceptable.

The test itself rests on a few assumptions, primarily that the first page load matters for web applications [2]. Further we assume that TodoMVC is a simple enough that it represents a minimal application for these frameworks: no second loads, minimal assets, minimal logic. Intuitively we've done our best to be generous in our measurements without exploring a different application entirely.

### Results

Of all the numbers collected, the **Render Start** was of primary interest based on our understanding of why the first load is important. This is the earliest point at which a user could conceivably report the application "ready to use".

Notable within the results are the following:

* Both Ember and Angular hover around 4 seconds to **Render Start** on the shaped 3G connection.

### Possible Issues
- "not built with speed in mind"
 - min'd js
 - css moved out of head
 - no background image
 - no base.js from todomvc_common
- "slow/poorly configured server"
 - TTFB is fast in the tests
 - compression used
- "server render not representative of complex backend"
 - We're not using the backbone_server as a baseline
 - Intension is to establish a basline for *each* framework
- "the nexus 5 results seem extreme"
 - we are focusing on the desktop 3G/Cable results

1. Popularity here is defined as "Those frameworks we've heard the most noise about recently".
2. Link to information on why first load matters
