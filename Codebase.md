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

## draft for the pull request

Absolutely! Here is the cleaned-up and copy-paste-ready version of your project description, formatted professionally for a `README.md` file:

---

## Project Overview

To encourage a cleaner and more maintainable codebase, this application is structured using multiple controllers. Each controller is responsible for a specific feature or set of features. The goal is to streamline functionality, simplify debugging, and support scalability.

---

### Home Controller

**Responsibilities:**

- Loads the root (`/`) page.
- Displays a list of previously analyzed pages saved in the database.
- If no pages have been analyzed yet, displays the message:
  _"No pages analyzed yet. Enter a URL above to begin!"_

---

### ContentPages Controller

**Responsibilities:**

- Handles user-submitted URLs for analysis.
- Triggers the analysis pipeline.
- Renders a results page showing:

  - Page title
  - Table of contents (if found)
  - Total word count
  - Top 10 most frequent words

This controller delegates heavy-lifting tasks to a parent service class: `PageAnalyser`.

---

### PageAnalyser (Service)

This service acts as the core engine for the analysis pipeline. It performs:

1. URL validation and HTML fetching
2. Content extraction and analysis

If all checks and analyses succeed, the results are saved into the database as a new `ContentPage` record.

---

#### URL Service (Submodule)

Handles all validation and accessibility checks before any analysis is attempted.

**Functions:**

- `url_validator`
  Validates the format of the user-entered URL.
  Checks for common issues like:

  - Whitespace
  - Unsupported URL schemes
  - Blank or missing host
    Returns a warning if invalid, prompting user correction.

- `fetcher`
  Attempts to fetch an HTML document from the provided URL.
  If the server is unresponsive or the page is private (e.g., a non-public Google Doc), an error is returned.

These checks prevent wasted resources on analyzing invalid, inaccessible, or unsupported URLs.

---

#### Extraction Service (Submodule)

Once a valid HTML document is retrieved, the Extraction module performs in-depth analysis using the Nokogiri library.

**Functions:**

- `title_extractor`
  Extracts the page’s `<title>` tag.
  If missing or empty, returns an error and halts further analysis.

- `toc_extractor`
  Attempts to extract a structured Table of Contents.
  If not found, returns a message stating no TOC was detected.

- `top_10_words_extractor`
  Returns the 10 most frequently used words on the page.
  Note: Consider edge cases such as when the page has fewer than 10 unique words.

- `word_counter`
  Returns the total number of words found in the document.

---

### When All Steps Succeed

A new record is saved in the database:

```ruby
{
  title: title,
  url: url,
  table_of_contents: toc,
  word_count: word_count,
  top_10_words: top_words
}
```

The user is then presented with a summary of findings.

---

### HistoryPages Controller

**Responsibilities:**

- When a user clicks on a previously analyzed page:

  - Extracts the ID from the URL
  - Fetches the corresponding record from the `ContentPage` database
  - Renders a page at `/history_pages/:id` displaying the saved analysis

---
