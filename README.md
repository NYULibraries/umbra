# Umbra

[![Build Status](https://travis-ci.org/NYULibraries/umbra.png?branch=master)](https://travis-ci.org/NYULibraries/umbra)
[![Dependency Status](https://gemnasium.com/NYULibraries/umbra.png)](https://gemnasium.com/NYULibraries/umbra)
[![Code Climate](https://codeclimate.com/github/NYULibraries/umbra.png)](https://codeclimate.com/github/NYULibraries/umbra)
[![Coverage Status](https://coveralls.io/repos/NYULibraries/umbra/badge.png?branch=master)](https://coveralls.io/r/NYULibraries/umbra)

Umbra is a Solr-based search interface that implements Blacklight as its frontend discovery tool and Sunspot as its backend administration tool. Umbra uses WebSolr as its cloud-hosted Solr index.

## Starting up a development Solr instance

Use the foreman Procfile to manage startup tasks:

```
bundle exec foreman start
```

## Blacklight

Implements [Blacklight](http://projectblacklight.org/) gem to take advantage of the Solr-indexed catalog discovery.

## Sunspot

Uses the [Sunspot](http://sunspot.github.com/) gem to manage the indexing of collections into WebSolr.

### Deleting all records from Solr

To delete all the records from the index do the following in the Rails console:

    Sunspot.remove_all(Umbra::Record)

### Reindexing all records into Solr

If for some reason the index falls out or gets corrupted you can reindex all records from the database back into Solr with the following:

    RAILS_ENV={ENV} bundle exec rake sunspot:reindex[{BATCH_SIZE},'Umbra::Record']

where `{ENV}` is the Rails environment and `{BATCH_SIZE}` is a number to batch load. Batch loading helps if you're having connectivity problems to WebSolr. I'd say `25` is a safe bet for batch size in this project.
