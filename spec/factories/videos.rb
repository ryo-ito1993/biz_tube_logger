FactoryBot.define do
  factory :video do
    youtube_id { 'z9EUo-T5v6Q' }
    title { '【マーケティングとは？】ＵＳＪを劇的に変えた、たった１つの考え方｜日本一わかりやすい「マーケティング講座」です。' }
    view_count { '400983' }
    published_at { 'Sat, 17 Jul 2021 01:15:00.000000000 UTC +00:00' }
    thumbnail { 'https://i.ytimg.com/vi/z9EUo-T5v6Q/hqdefault.jpg' }
    association :user
  end
end