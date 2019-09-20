# Report Updater
[![CircleCI](https://circleci.com/gh/JamaSoftware/velocity-report-updater.svg?style=svg)](https://circleci.com/gh/JamaSoftware/velocity-report-updater)

This repository contains a script to automate the updating of existing Velocity report templates to use the correct references defined on the context.

The `applicationContext` is no longer avalible to templates, and a corresponding "source" should be used depending on what data the report needs to access.


## Disclaimer
The script operates on files in place. Make sure you are using source control or have backups before continuing!


## Usage
After downloading or cloning this repo run the script `report-updater.sh` with one argument of the path to the Velocity templates to be updated.
```sh
./report-updater.sh ~/reports
```

### Contributing
When making updates to this repo, add a corresponding test line in `test/input.vm`
and a matching output line in `test/output.vm`
