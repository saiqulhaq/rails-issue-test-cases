# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"
  
  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  # Activate the gem you are reporting the issue against.
  gem "activerecord", "~> 6.1.7"  # Match the Rails version with the one reported in the issue
  gem "sqlite3"
end

require "active_record"
require "minitest/autorun"
require "logger"

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :suppliers, force: true do |t|
    t.string :name
  end

  create_table :accounts, force: true do |t|
    t.integer :supplier_id
    t.integer :account_number
  end
end

class Supplier < ActiveRecord::Base
  has_one :account, inverse_of: :supplier
end

class Account < ActiveRecord::Base
  belongs_to :supplier, inverse_of: :account
  accepts_nested_attributes_for :supplier, update_only: true
end

class BugTest < Minitest::Test
  # def test_supplier_update
  #   supplier = Supplier.create!(name: 'initial supplier')
  #   account = Account.create!(supplier: supplier)

  #   account.update(supplier_attributes: { name: 'new supplier' })

  #   assert_equal({"supplier_id"=>[supplier.id, account.supplier_id]}, account.saved_changes)
  # end


  # def test_update_existing_supplier
  #   supplier = Supplier.create!(name: 'initial supplier')
  #   account = Account.create!(supplier: supplier)

  #   new_name = 'update my supplier'
  #   account.update(supplier_attributes: { id: account.supplier_id, name: new_name })
  #   assert_equal(Supplier.count, 1)
  #   assert_equal({"supplier_id"=>[supplier.id, account.supplier_id]}, account.saved_changes)

  #   supplier.reload
  #   assert_equal(supplier.name, new_name)
  # end

  # def test_supplier_saved_changes_is_available_after_update
  #   supplier = Supplier.create(name: 'my supplier')
  #   account = Account.create(supplier: supplier, account_number: '123')

  #   account.update(account_number: '99129', supplier_attributes: { name: 'new supplier' })
  #   assert_equal account.supplier.saved_changes.keys, ['id', 'name']
  #   # assert_equal @account.saved_changes.present?, true 
  # end

  def test_account_saved_changes_is_available_after_update
    supplier = Supplier.create(name: 'my supplier')
    account = Account.create(supplier: supplier, account_number: '123')

    account.update account_number: nil, supplier_attributes: { name: 'new supplier' } 

    assert_equal account.supplier.saved_changes, {"name"=>["my supplier", "new supplier"]}
  end
end
