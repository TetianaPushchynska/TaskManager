require 'rails_helper'

RSpec.describe 'Factory Bot' do
  FactoryBot.factories.map(&:name).each do |factory_name|
    describe "#{factory_name} factory" do
      before { FactoryBot.use_parent_strategy = false }

      it 'is valid', :skip_before_gus do
        factory = build(factory_name)
        if factory.respond_to?(:valid?)
          expect(factory).to be_valid, -> { factory.errors.full_messages.join("\n") }
        end
      end

      FactoryBot.factories[factory_name].definition.defined_traits.map(&:name).each do |trait_name|
        context "with trait #{trait_name}" do
          it 'is valid' do
            factory = build(factory_name, trait_name)
            if factory.respond_to?(:valid?)
              expect(factory).to be_valid, -> { factory.errors.full_messages.join("\n") }
            end
          end
        end
      end
    end
  end
end
