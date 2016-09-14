# AgencyCrawler (Work in Progress)

A script to help find all the government agency websites!

Sample list, `ca-agencies.csv` from the Census of State and Local Governments, includes names of California municipal, county, and special district agencies, as well as tons of outdated agency websites.

## Features

+ Check for a valid, listed URL (done)
+ Check URL's current HTTP status (done)
+ Check Google for alternate agency URLs (in-progress)

## Roadmap

+ Check Google for alternate agency URLs (in-progress)
  + check listed url against search results
  + check agency name against search results for manual review
+ Output updated CSV of agencies

## Setup

```
require_relative './lib/agency_crawler'
AgencyCrawler.new('ca-agencies.csv')
```
