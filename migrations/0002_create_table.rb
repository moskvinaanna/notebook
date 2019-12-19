# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:statuses) do
      primary_key :id
      String :name, null: false, size: 100
    end
  end
end
