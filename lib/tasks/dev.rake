namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    filelink = ""
    filelink_array = []
    Dir.glob("#{Rails.root}/lib/assets/images/*.jpg").map do |pic|
      client = FilestackClient.new('AZrsl1q84SWqU9xu0VPEsz')
      filelink = client.upload(filepath: pic)
      filelink_array.push(filelink)
    end

    50.times do |i|
      restaurant = Restaurant.new(name: FFaker::Name.name,
                                  opening_hours: FFaker::Time.date,
                                  address: FFaker::Address.street_address,
                                  description: FFaker::Lorem.paragraph,
                                  tel: FFaker::PhoneNumber.phone_number,
                                  category: Category.all.sample
      )

      restaurant.image = filelink_array[rand(filelink_array.size)].url
      restaurant.save!

      #Sam範例
      # Dir.glob("#{Rails.root}/lib/assets/images/*.jpg").map do |pic|
      #   File.open(pic) do |f|
      #     restaurant.image = f
      #   end
      # end



      #隨機取本地端圖片
      # pic = Dir.glob("#{Rails.root}/lib/assets/images/*.jpg")
      # restaurant.image = File.open(pic[rand(3)])
      # restaurant.save!
    end
    puts "have created fake restaurants"
  end

  task fake_user: :environment do
    20.times do |i|
      user_name = FFaker::Name.first_name
      User.create!(
          email: "#{user_name}@example.com",
          password: "12345678"
      )
    end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end


  task fake_comment: :environment do
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
            content: FFaker::Lorem.sentence,
            user: User.all.sample
        )
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comment data"
  end
end