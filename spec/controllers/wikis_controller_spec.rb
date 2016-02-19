require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:my_user){User.create!(email: "test@example.com", password: "password", confirmed_at: Time.now)}

  let(:valid_attributes) {
    {title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph}
  }

  let(:invalid_attributes) {
    {title: nil,
    body: nil}
  }

  before :each do
    sign_in my_user
  end

  describe "GET #index" do
    it "assigns all wikis as @wikis" do
      wiki = Wiki.create! valid_attributes
      get :index
      expect(assigns(:wikis)).to eq([wiki])
    end
  end

  describe "GET #show" do
    it "assigns the requested wiki as @wiki" do
      wiki = Wiki.create! valid_attributes
      get :show, {:id => wiki.to_param}
      expect(assigns(:wiki)).to eq(wiki)
    end
  end

  describe "GET #new" do
    it "assigns a new wiki as @wiki" do
      get :new
      expect(assigns(:wiki)).to be_a_new(Wiki)
    end
  end

  describe "GET #edit" do
    it "assigns the requested wiki as @wiki" do
      wiki = Wiki.create! valid_attributes
      get :edit, {:id => wiki.to_param}
      expect(assigns(:wiki)).to eq(wiki)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Wiki" do
        expect {
          post :create, {:wiki => valid_attributes}
        }.to change(Wiki, :count).by(1)
      end

      it "assigns a newly created wiki as @wiki" do
        post :create, {:wiki => valid_attributes}
        expect(assigns(:wiki)).to be_a(Wiki)
        expect(assigns(:wiki)).to be_persisted
      end

      it "redirects to the created wiki" do
        post :create, {:wiki => valid_attributes}
        expect(response).to redirect_to(Wiki.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved wiki as @wiki" do
        post :create, {:wiki => invalid_attributes}
        expect(assigns(:wiki)).to be_a_new(Wiki)
      end

      it "re-renders the 'new' template" do
        post :create, {:wiki => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      faker_paragraph = Faker::Lorem.paragraph

      let(:new_attributes) {
        {title: "New Title", body: faker_paragraph}
      }

      it "updates the requested wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, {:id => wiki.to_param, :wiki => new_attributes}
        wiki.reload
        expect(wiki.title).to eq("New Title")
        expect(wiki.body).to eq(faker_paragraph)
      end

      it "assigns the requested wiki as @wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, {:id => wiki.to_param, :wiki => valid_attributes}
        expect(assigns(:wiki)).to eq(wiki)
      end

      it "redirects to the wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, {:id => wiki.to_param, :wiki => valid_attributes}
        expect(response).to redirect_to(wiki)
      end
    end

    context "with invalid params" do
      it "assigns the wiki as @wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, {:id => wiki.to_param, :wiki => invalid_attributes}
        expect(assigns(:wiki)).to eq(wiki)
      end

      it "re-renders the 'edit' template" do
        wiki = Wiki.create! valid_attributes
        put :update, {:id => wiki.to_param, :wiki => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested wiki" do
      wiki = Wiki.create! valid_attributes
      expect {
        delete :destroy, {:id => wiki.to_param}
      }.to change(Wiki, :count).by(-1)
    end

    it "redirects to the wikis list" do
      wiki = Wiki.create! valid_attributes
      delete :destroy, {:id => wiki.to_param}
      expect(response).to redirect_to(wikis_url)
    end
  end
end
