require 'rails_helper'

def create_and_activate_user(name)
  user = User.create!(name:, email: "#{name}@example.com", password: '123456', bio: "Bio of #{name}", photo: "#{name}.jpg")
  user.confirm
  user.save
  create_posts_for_user(user, count: 4)
  user
end

def create_posts_for_user(author, count: 1)
  count.times do |i|
    Post.create(author:, title: "Post #{i} by #{author.name}", text: 'This is a post')
  end
end

feature 'User Show' do
  background do
    @name = 'user'
    @user = create_and_activate_user(@name)

    visit user_path(@user)
  end

  scenario 'shows the profile picture of user' do
    expect(page).to have_css "img[src='#{@name}.jpg']"
  end

  scenario 'shows username of user' do
    expect(page).to have_content @name
  end

  scenario 'shows the count of posts by user i.e. 4' do
    expect(page).to have_content 'Number of posts: 4'
  end

  scenario 'shows the bio of user' do
    expect(page).to have_content "Bio of #{@name}"
  end

  scenario 'shows the last 3 posts by user' do
    3.downto(1).each { |i| expect(page).to have_content "Post #{i} by #{@name}" }
  end

  scenario 'shows a button to show all posts by user' do
    expect(page).to have_button 'See all posts'
  end

  scenario 'gets redirected to post page after user clicks on a post' do
    click_link "Post 1 by #{@name}"

    expect(page).to have_current_path(user_post_path(@user, @user.posts.second))
  end

  scenario 'gets redirected to all posts page when user clicks on see all posts button' do
    click_link 'See all posts'

    expect(page).to have_current_path(user_posts_path(@user))
  end
end
