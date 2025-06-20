# Zipline Grouping

A command-line Ruby app that identifies matching records in a CSV file based on email, phone number, or both.

## 🚀 How to Run

```bash
./bin/group_records.rb -i input.csv -m email -o output.csv
```

```
-i, --input FILE                 Path to input file
-m, --matcher MATCHER            Matcher to use
-o, --output FILE                Path to output file (optional)
```

If `--output` is not provided, results will be written to a file with a default name (`grouped_INPUT_NAME.csv`)

### Match Types

- `email`: Match by normalized email address
- `phone`: Match by normalized phone number
- `email_or_phone/phone_or_email`: Match by either email or phone

## ✅ How to Run Tests

```bash
bundle install
bundle exec rspec
```

## 🧠 Solution Overview


This solution groups records from a CSV file that likely represent the same person based on configurable matchers such as email address or phone number. It uses a Union-Find (Disjoint Set Union) data structure to efficiently track and merge connected records.


### 🔧 Key Components

- `Record`: Parses and holds data for each row.
- `Normalizer`: Cleans fields like email and phone numbers for consistent matching.
- `BaseMatcher` and its subclasses (`EmailMatcher`, `PhoneMatcher`, `EmailOrPhoneMatcher`): Encapsulate matching logic for each field.
- `UnionFind`: Maintains and merges record groups that are matched.
- `group_records.rb` (main entrypoint): Loads records, runs all matchers, groups matched records, and writes the result into an output file.


## 💾 Data Structures

| Component     | Purpose                              |
|---------------|--------------------------------------|
| `HashMap`     | Group records by normalized values   |
| `UnionFind`   | Efficient grouping using union/find  |
| `Array`       | Store and iterate over records       |

