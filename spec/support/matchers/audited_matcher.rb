require 'rspec/expectations'

RSpec::Matchers.define :define_audits do
  match do
    described_class.included_modules.include?(Audited::Auditor::AuditedInstanceMethods)
  end
end
