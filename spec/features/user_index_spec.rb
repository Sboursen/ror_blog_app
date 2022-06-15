require 'rails_helper'

def create_posts_for_user(author, count: 1)
  count.times do |i|
    Post.create!(author:, title: "Post #{i} by #{author.name}", text: 'This is a post')
  end
end

def create_and_activate_user(name)
  user = User.create!(name:, email: "#{name}@example.com", password: '123456')
  user.confirm
  user.photo = "#{name}.jpg"
  user.save
  user
end

describe 'User Index', type: :feature do
  before do
    @name1 = 'user1'
    @user1 = create_and_activate_user(@name1)
    create_posts_for_user(@user1, count: 1)

    @name2 = 'user2'
    @user2 = create_and_activate_user(@name2)
    create_posts_for_user(@user2, count: 5)

    visit users_path
  end

  it 'shows username of all the users' do
    expect(page).to have_content @name1
    expect(page).to have_content @name2
  end

  it 'shows photos of all the users' do
    expect(page).to have_css "img[src='#{@name1}.jpg']"
    expect(page).to have_css "img[src='#{@name2}.jpg']"
  end

  it 'shows number of posts if users have posts' do
    visit users_path

    expect(page).to have_content 'Number of posts: 1'
    expect(page).to have_content 'Number of posts: 5'
  end

  it 'gets redirected to user page after click on it' do
    click_link @name1

    expect(page).to have_current_path(user_path(@user1))
  end
end
