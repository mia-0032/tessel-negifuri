tessel-simple-negifuri
======================

simple negifuri with servo and tessel

## Setup

Connect your servo motor control line to Tessel `G4` port.

```
# setup this application.
$ git clone https://github.com/mia-0032/tessel-simple-negifuri.git
$ cd tessel-simple-negifuri
$ npm install
```

## Test Run

```
$ tessel run index.js
```

## Stand-alone Run

```
$ tessel push index.js
```

## Edit Program

If you edit program, you need to install coffee-script.

```
$ npm install -g coffee-script
```

And compile script after editting `index.coffee`.

```
$ coffee -c index.coffee
```
