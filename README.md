Qsome
=====
[![Build Status](https://travis-ci.org/seomoz/qsome-rb.svg?branch=dan/travis-build)](https://travis-ci.org/seomoz/qsome-rb)

It's like `qless`, but with subqueues.

In support of another project for which we need logical groupings of thousands
of queues, we wrote `qsome`. It allows us to talk about groups of `qless` queues
as if they were logically single queues. In a given superqueue, we want at most
one (actually, this is configurable) job from any given subqueue running at any
given time.
