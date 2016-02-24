# Xctester

[![Gem Version](https://badge.fury.io/rb/xctester.svg)](https://badge.fury.io/rb/xctester)

Xctester is a basic script that run Xcode tests and generate log files for each run.

## Installation


Simply install it  as:

    $ gem install xctester

## Usage

```
./xctester -h
Usage: ./xctester [options]
   -v, --[no-]verbose               Run verbosely
   -t, --tests test                 Specify how many time you want to run your unit tests
   -s, --scheme scheme              The scheme to execute
   -p, --project project            The project file (xcodeproj) or workspace file (xcworkspace) to test
   -o, --timeout timeout            The maximun time (in seconds) allowed to launch the test
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/nonouf/xctester.
