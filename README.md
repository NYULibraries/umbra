# Umbra

[![Build Status](http://jenkins1.bobst.nyu.edu/job/Umbra%20Production/badge/icon)](http://jenkins1.bobst.nyu.edu/job/Umbra%20Production/)
[![Dependency Status](https://gemnasium.com/NYULibraries/umbra.png)](https://gemnasium.com/NYULibraries/umbra)
[![Code Climate](https://codeclimate.com/github/NYULibraries/umbra.png)](https://codeclimate.com/github/NYULibraries/umbra)

Umbra is a Solr-based search interface that implements Blacklight as its frontend discovery tool and Sunspot as its backend administration tool. WebSolr is the cloud Solr client Umbra utilizes.

## Blacklight

Implements Blacklight engine gem to take advantage of the Solr-indexed catalog discovery.

* [Blacklight](http://projectblacklight.org/)

## Sunspot

Uses the Sunspot gem to manage the indexing of collections into WebSolr.

* [Sunspot](http://sunspot.github.com/)