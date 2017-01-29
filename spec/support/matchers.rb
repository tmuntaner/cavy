RSpec::Matchers.define :allow do |*args|
  match do |permission|
    expect(permission.allow?(*args)).to be_truthy
  end
end

RSpec::Matchers.define :allow_param do |*args|
  match do |permission|
    expect(permission.allow_param?(*args)).to be_truthy
  end
end