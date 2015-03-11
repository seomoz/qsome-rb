Qsome
=====
[![Build Status](https://travis-ci.org/seomoz/qsome-rb.svg?branch=master)](https://travis-ci.org/seomoz/qsome-rb)

It's like [`qless`](https://github.com/seomoz/qless), but with subqueues.

In support of another project for which we need logical groupings of thousands
of queues, we wrote `qsome`. It allows us to talk about groups of `qless` queues
as if they were logically single queues. In a given superqueue, we want at most
one (actually, this is configurable) job from any given subqueue running at any
given time.

![Status: Incubating](https://img.shields.io/badge/status-incubating-blue.svg?style=flat)
![Team: Big Data](https://img.shields.io/badge/team-big_data-green.svg?style=flat)
![Scope: External](https://img.shields.io/badge/scope-external-green.svg?style=flat)
![Open Source: Yes](https://img.shields.io/badge/open_source-MIT-green.svg?style=flat)
![Critical: No](https://img.shields.io/badge/critical-no-lightgrey.svg?style=flat)
