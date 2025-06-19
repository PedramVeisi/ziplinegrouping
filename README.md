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