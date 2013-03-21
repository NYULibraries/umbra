# Umbra

[![Build Status](http://jenkins1.bobst.nyu.edu/job/Umbra%20Production/badge/icon)](http://jenkins1.bobst.nyu.edu/job/Umbra%20Production/)

[![Build Status](https://travis-ci.org/NYULibraries/umbra.png?branch=master)](https://travis-ci.org/NYULibraries/umbra)
[![Dependency Status](https://gemnasium.com/NYULibraries/umbra.png)](https://gemnasium.com/NYULibraries/umbra)
[![Code Climate](https://codeclimate.com/github/NYULibraries/umbra.png)](https://codeclimate.com/github/NYULibraries/umbra)
[![Coverage Status](https://coveralls.io/repos/NYULibraries/umbra/badge.png?branch=master)](https://coveralls.io/r/NYULibraries/umbra)

Umbra is a Solr-based search interface that implements Blacklight as its frontend discovery tool and Sunspot as its backend administration tool. WebSolr is the cloud Solr client Umbra utilizes.

## Blacklight

Implements Blacklight engine gem to take advantage of the Solr-indexed catalog discovery.

* [Blacklight](http://projectblacklight.org/)

## Sunspot

Uses the Sunspot gem to manage the indexing of collections into WebSolr.

To delete all the records from the index do the following in the Rails console:

    Sunspot.remove_all(Umbra::Record)

* [Sunspot](http://sunspot.github.com/)