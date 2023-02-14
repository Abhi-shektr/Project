FactoryBot.define do
    factory :authentication do
        grant_type{password}
        client_id{n8604qtTTPyk_6mKCbNDlqshAFX2thvrFeFbk4W6s-Y}
        client_secret{password123}
        email{mahesh@gmail.com}
        password{mahesh}
    end
  end