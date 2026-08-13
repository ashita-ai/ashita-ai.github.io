#!/usr/bin/env ruby
# frozen_string_literal: true

require 'csv'
require 'json'

root = File.expand_path('..', __dir__)
data_dir = File.join(root, 'assets/data/conflict-detection')
csv_path = File.join(data_dir, 'conflict-labels.csv')
jsonl_path = File.join(data_dir, 'conflict-pairs-recoded.jsonl')

csv = CSV.read(csv_path, headers: true).map(&:to_h).to_h { |row| [row.fetch('pair_id'), row] }
pairs = File.readlines(jsonl_path, chomp: true).map { |line| JSON.parse(line) }
pair_ids = pairs.map { |pair| pair.fetch('pair_id') }
marked_ids = csv.select { |_, row| row['in_recoded_subset'] == 't' }.keys

errors = []
errors << "expected 192 recoded pairs, found #{pairs.length}" unless pairs.length == 192
errors << 'recoded pair IDs are not unique' unless pair_ids.uniq.length == pair_ids.length
errors << 'recoded pair IDs do not equal the CSV marked subset' unless pair_ids.sort == marked_ids.sort

pairs.each do |pair|
  row = csv[pair['pair_id']]
  next errors << "missing CSV row for #{pair['pair_id']}" unless row

  %w[gold_label decision_type_a decision_type_b].each do |field|
    errors << "#{field} differs for #{pair['pair_id']}" unless pair[field] == row[field]
  end
end

denylist = %w[
  Supabase Qdrant PostgreSQL Postgres GitHub Alembic Linear React Docker dbt
  BigQuery DuckDB Jira SQLite Vitest Playwright OpenTelemetry OTel Ollama
  TimescaleDB Claude Codex
]
text = pairs.flat_map { |pair| pair.values_at('decision_a', 'decision_b') }.join("\n")
denylist.each do |term|
  errors << "unredacted product or agent name: #{term}" if text.match?(/\b#{Regexp.escape(term)}\b/i)
end
errors << 'email address survived redaction' if text.match?(/\b[\w.+-]+@[\w.-]+\.[A-Za-z]{2,}\b/)
errors << 'absolute filesystem path survived redaction' if text.match?(%r{(?<![\w])/(?:Users|home|tmp|var|opt|etc)/})
errors << 'commit hash survived redaction' if text.match?(/\b[0-9a-f]{7,}\b/i)

unless errors.empty?
  warn errors.join("\n")
  exit 1
end

puts "conflict-detection data check passed: #{pairs.length} joinable, redacted pairs"
