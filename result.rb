# result.rb
require ('pry')

class Result < ActiveRecord::Base
  belongs_to(:place)
  validates(:test_date, :lab, :over_limit, :place_id, :user_id {:presence => true})
end

# result_spec.rb
require("spec_helper")

describe(Brand) do
  describe('#validates') do
    it("validates presence of test_date") do
      result = Result.new({:lab => 'Pixis Laboratory', :over_limit => 'true', :place_id => '4' :user_id => '15', :test_date => ''})
      expect(result.save()).to(eq(false))
    end
  end

  describe('#place') do
    it("says which place a result belongs to") do
      test_place = Place.create({:address_line1 => "400 SW 6th Avenue", :city => 'Portland', :state => 'Oregon'})
      result = Result.create({:lab => 'Pixis Laboratory', :over_limit => 'true', :test_date => '2016-05-05', :place_id => test_place.id})
      expect(result.place()).to(eq(test_place))
    end
  end

  describe('#user') do
    it("says which user posted a result") do
      test_user = User.create({NOT SURE WHAT NEEDS TO GO HERE!})
      test_place = Place.create({:address_line1 => "400 SW 6th Avenue", :city => 'Portland', :state => 'Oregon'})
      result = Result.create({:lab => 'Pixis Laboratory', :over_limit => 'true', :test_date => '2016-05-05', :user_id => test_user.id, :place_id => test_place.id})
      expect(result.user()).to(eq(test_user))
    end
  end

# place.erb
<div class="center">
  <h1> <%= @place.name %> </h1>
  <p class="address"><%= @place.address_line1 %>, <%= @place.address_line2 %><%= @place.city %>, <%= @place.state %><%= @place.zipcode %></p>
</div>
  <div class="row">
    <div class="col-sm-6 col-sm-offset-3">
      <h2 class="center">Should you drink here?</h2>
      <h2 class="center">In our opinion... </h2>
    </div>
  </div>
  <div class="row">
    <div class="col-sm-4 col-sm-offset-4">
      <% if @place.results().any?() %>
      <ul>
        <% @place.results.each do |result| %>
        <li>Test Date: <%= result.test_date() %>, Tested at: <%= result.lab() %>,
        <% if result.over_limit() %>
          Water from drinking faucet(s) or fountain(s) tested over the 15ppm EPA limit.
          <% else %>
          Water from drinking faucet(s) or fountain(s) did not test over the 15ppm EPA limit.
        <% end %>
        </li>
      <ul>
      <% else %>
      <p> There are no test results posted for this place yet.</p>
      <% end %>
    </div>
  </div>

  # NOT EDITED YET...
  <div class="row">
    <div class="col-sm-2 col-sm-offset-2">
      <p><a class="btn btn-warning btn-lg btn-block" href="/places/<%= @place.id() %>/edit">Edit</a></p>
    </div>
    <div class="col-sm-2 col-sm-offset-1">
      <form action="/places/<%= @place.id() %>" method="post">
        <input name="_method" type="hidden" value="delete">
        <button type="submit" class="btn btn-danger btn-lg btn-block">Delete</button>
      </form><br>
    </div>
    <div class="col-sm-2 col-sm-offset-1">
      <p><a class="btn btn-primary btn-lg btn-block" href="/places">Back</a></p>
    </div>
  </div>
