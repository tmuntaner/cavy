require "spec_helper"

module Cavy
  describe Permissions::GuestPermission do
    subject { Permissions.permission_for(nil) }

    # it "allows investigations" do
    #   should_not allow(:investigations, :new_note)
    #   should_not allow(:investigations, :create_note)
    #   should_not allow(:investigations, :edit)
    #   should_not allow(:investigations, :update)
    #   should_not allow(:investigations, :destroy)
    #   should_not allow(:investigations, :show)
    #   should_not allow(:investigations, :close_case)
    #   should_not allow(:investigations, :open_case)
    #   should_not allow(:investigations, :index)
    #   should_not allow(:investigations, :create)
    # end

    # it "allows requests" do

    #   should allow(:requests, :index)
    #   should allow(:requests, :show)
    #   should_not allow(:requests, :new)
    #   should_not allow(:requests, :create)
    #   should_not allow(:requests, :edit)
    #   should_not allow(:requests, :update)
    # end

    # it "allows sightings" do
    #   should allow(:sightings, :index)
    #   should allow(:sightings, :show)
    #   should_not allow(:sightings, :new)
    #   should_not allow(:sightings, :create)
    #   should_not allow(:sightings, :edit)
    #   should_not allow(:sightings, :update)
    #   should_not allow(:sightings, :add_to_investigation)
    #   should_not allow(:sightings, :add_sighting)
    # end

    # it "allows pages" do
    #   should allow(:pages, :welcome)
    #   should allow(:pages, :map)
    #   should allow(:pages, :location)
    #   should allow(:pages, :compendium)
    #   should allow(:pages, :contact)
    # end

    # it "allows hunters" do
    #   should allow(:hunter, :show)
    #   should allow(:hunter, :index)
    #   should_not allow(:hunter, :become_hunter)
    #   should_not allow(:hunter, :update_to_hunter)
    # end

    # it "allows creatures" do
    #   should allow(:creatures, :index)
    #   should allow(:creatures, :show)
    #   should_not allow(:creatures, :new)
    #   should_not allow(:creatures, :edit)
    #   should_not allow(:creatures, :update)
    #   should_not allow(:creatures, :create)
    # end

    # it "allows sessions" do
    #   should allow(:sessions, :new)
    #   should allow(:sessions, :create)
    #   should allow(:sessions, :destroy)
    # end

    # it "allows users" do
    #   should allow(:users, :new)
    #   should allow(:users, :create)
    #   should allow(:users, :try)
    #   should_not allow(:users, :edit)
    #   should_not allow(:users, :update)
    # end

    # it "allows contact form" do
    #   should allow(:contacts,:new)
    #   should allow(:contacts,:create)
    #   should_not allow(:contacts,:edit)
    #   should_not allow(:contacts,:update)
    #   should_not allow(:contacts,:destroy)
    #   should_not allow(:contacts,:index)
    #   should_not allow(:contacts,:show)
    # end
    # it "allows feature requests" do
    #   should_not allow(:features,:new)
    #   should_not allow(:features,:create)
    #   should_not allow(:features,:edit)
    #   should_not allow(:features,:update)
    #   should_not allow(:features,:destroy)
    #   should allow(:features,:index)
    #   should allow(:features,:show)
    # end
  end
end