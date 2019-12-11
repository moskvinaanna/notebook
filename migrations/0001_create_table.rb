Sequel.migration do
    change do
        create_table(:notes) do
            primary_key :id
            String :name, null: false, size: 100
            String :surname, null: true, size: 100
            String :patronymic_name, null: true, size: 100
            String :cell_phone_num, null: true, size: 20
            String :home_phone_num, null: true, size: 15
            String :address, null: true, size: 200
            Date :birthday_date, null: true
            String :gender, null: false
            String :status, null: false, size: 100
          end
    end
end