require 'rails_helper'

RSpec.describe CollaborationsController, type: :controller do

  let(:my_user){User.create!(email: "test@example.com", password: "password", confirmed_at: Time.now)}
  let(:my_user2){User.create!(email: "test2@example.com", password: "password", confirmed_at: Time.now)}
  let(:my_wiki){Wiki.create!(title: Faker::Lorem.sentence , body: Faker::Lorem.paragraph)}

  let(:valid_attributes) {
    {user_id: my_user.id
    }
  }

  let(:invalid_attributes) {
    {user_id: nil
    }
  }

  before :each do
    sign_in my_user

    my_user.wikis << my_wiki
  end

  describe "GET #index" do
    it "assigns all collaborations as @collaborations" do
      get :index, {wiki_id: my_wiki.id}
      expect(assigns(:users)).to include(my_user)
    end
  end

  describe "GET #new" do
    it "assigns a new collaboration as @collaboration" do
      get :new, {wiki_id: my_wiki.id}
      expect(assigns(:collaboration)).to be_a_new(Collaboration)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Collaboration" do
        expect {
          post :create, {wiki_id: my_wiki.id, user_id: my_user.id}
      }.to change(my_wiki.collaborations, :count).by(1)
      end

      it "assigns a newly created collaboration as @collaboration" do
        post :create, {wiki_id: my_wiki.id, user_id: my_user.id}
        expect(assigns(:collaboration)).to be_a(Collaboration)
        expect(assigns(:collaboration)).to be_persisted
      end

      it "redirects to the created collaboration" do
        post :create, {wiki_id: my_wiki.id, user_id: my_user.id}
        expect(response).to redirect_to(wiki_collaborations_path(my_wiki))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved collaboration as @collaboration" do
        post :create, {wiki_id: my_wiki.id, :collaboration => invalid_attributes}
        expect(assigns(:collaboration)).to be_a_new(Collaboration)
      end

      it "re-renders the 'new' template" do
        post :create, {wiki_id: my_wiki.id, :collaboration => invalid_attributes}
        expect(response).to redirect_to(wiki_collaborations_path(my_wiki))
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested collaboration" do
      collaboration = Collaboration.create! valid_attributes
      expect {
        delete :destroy, {wiki_id: my_wiki.id, :id => collaboration.to_param}
      }.to change(Collaboration, :count).by(-1)
    end

    it "redirects to the collaborations list" do
      collaboration = Collaboration.create! valid_attributes
      delete :destroy, {wiki_id: my_wiki.id, :id => collaboration.to_param}
      expect(response).to redirect_to(wiki_collaborations_path(my_wiki))
    end
  end

end
