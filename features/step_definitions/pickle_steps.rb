# -*- encoding : utf-8 -*-
# this file generated by script/generate pickle

# create a model
Given(/^#{capture_model} exists?(?: with #{capture_fields})?$/) do |name, fields|
  create_model(name, fields)
end

# create n models
Given(/^(\d+) #{capture_plural_factory} exist(?: with #{capture_fields})?$/) do |count, plural_factory, fields|
  count.to_i.times { create_model(plural_factory.singularize, fields) }
end

# create models from a table
Given(/^the following #{capture_plural_factory} exists?:?$/) do |plural_factory, table|
  name = plural_factory.singularize
  table.hashes.each { |hash| create_model(name, hash) }
end

# find a model
Then(/^#{capture_model} should exist(?: with #{capture_fields})?$/) do |name, fields|
  find_model!(name, fields)
end

# not find a model
Then(/^#{capture_model} should not exist(?: with #{capture_fields})?$/) do |name, fields|
  find_model(name, fields).should be_nil
end

# find models with a table
Then(/^the following #{capture_plural_factory} should exists?:?$/) do |plural_factory, table|
  name = plural_factory.singularize
  table.hashes.each { |hash| find_model!(name, hash)}
end

# find exactly n models
Then(/^(\d+) #{capture_plural_factory} should exist(?: with #{capture_fields})?$/) do |count, plural_factory, fields|
  find_models(plural_factory.singularize, fields).size.should == count.to_i
end

# assert equality of models
Then(/^#{capture_model} should be #{capture_model}$/) do |a, b|
  model!(a).should == model!(b)
end

# assert model is in another model's has_many assoc
Then(/^#{capture_model} should be (?:in|one of|amongst) #{capture_model}(?:'s)? (\w+)$/) do |target, owner, association|
  model!(owner).send(association).should include(model!(target))
end

# assert model is not in another model's has_many assoc
Then(/^#{capture_model} should not be (?:in|one of|amongst) #{capture_model}(?:'s)? (\w+)$/) do |target, owner, association|
  model!(owner).send(association).should_not include(model!(target))
end

# assert model is another model's has_one/belongs_to assoc
Then(/^#{capture_model} should be #{capture_model}(?:'s)? (\w+)$/) do |target, owner, association|
  model!(owner).send(association).should == model!(target)
end

# assert model is not another model's has_one/belongs_to assoc
Then(/^#{capture_model} should not be #{capture_model}(?:'s)? (\w+)$/) do |target, owner, association|
  model!(owner).send(association).should_not == model!(target)
end