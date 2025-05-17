## .github - GitHub Actions config to keep code safe and healthy

    workflows - automatically runs security scans, code style checks, and tests on every push or pull request to ensure the code is safe and working correctly
    dependeabot.yml - config for a tool that helps you keep your dependencies up to date

## .kamal - deployment config for the app that handles automation of pushing your code live.

    hooks - scripts that run automatically during deployment
    secrets - sensitive info needed for deployment

## bin - contains executable commands to test, run and manage the app easily

## config

    environments - configures how the application behaves in each environment
    initializers - ruby scripts that run when the app boots
    locales - stores translation files
    .yml files - store data, settings and values that app reads when it runs
    .rb files - contain Ruby code that runs and modify app config logic

## db

    cable_schema.rb - defines structure for handling live features (WebSockets)
    cache_schema.rb - defines the schema for caching data in the database
    queue_schema.rb - db structure for handling background tasks,
    seeds.rb - a script that fills your data with started data

## lib - a place for custom code, helpers or modules

## log - this is where our app keeps track of what is happening (events, request, errors)

    .keep - a empty placeholder file that makes sure an empty log folder gets included in the project/repository
    .development.log  -  records all the requests, errors, warnings, and other messages when we are running the app locally

## public - a folder for static files

    .html files - static files that the app serves for a specific HTTP error code

## script/ — legacy folder similar to bin/, may contain old Rails scripts or custom helper scripts.

## storage/ = Rails' local file upload holding area.

    .keep = keeps the folder in version control.
    development.sqlite1 / test.sqlite = small internal databases used to track file attachments during dev/test.

## test - holds all the automated checks for your app.

    each subfolder targets a specific part (controllers, models, etc.).

## tmp - working area for caching, process tracking, and temporary files (useful for debugging and development).

    cache/ - stores temporary cached data (e.g., view fragments, assets, etc.)
    pids/ - stores PID (process ID) files to track running server processes
    sockets/ - stores socket files for local communication (e.g., with Puma server)
    storage/ - temporary file storage, often used during Active Storage operations

## vendor - holds external libraries not managed by gem/npm packages
