require 'csv'

CSV.foreach('/Users/briankung/Downloads/dones.csv', headers: true) do |r|
  r['text'].split("\n").each do |done|
    Done.create created_at: Time.strptime(r['date'], '%m/%d/%Y'), text: done
  end
end
