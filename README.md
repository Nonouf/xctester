# xctester
A basic script that run Xcode tests

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

## Requirements

- Ruby
- `bundle install`
