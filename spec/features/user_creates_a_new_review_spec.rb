require "rails_helper"

describe "user creates a new review" do
  describe "they link from a books show page" do
    describe "they fill in a title, score, and description" do
      it "creates a new review" do

        @book_1 = Book.create(
          title: "Book 1",
          pages: 200,
          year: 2000)

        visit book_path(@book_1)
        click_link "Create a New Review"

        expect(current_path).to eq(new_book_review_path(@book_1))
        # visit new_book_review_path(@book_1)

        fill_in "username", with: "New Name"
        fill_in "review[title]", with: "New Title"
        fill_in "review[score]",  with: 4
        fill_in "review[description]",  with: "This is a new description."
        click_on "Create Review"


        expect(page).to have_content("New Name")
        expect(page).to have_content("New Title")
        expect(page).to have_content("4/5")
        expect(page).to have_content("This is a new description.")
      end
    end
  end
end
